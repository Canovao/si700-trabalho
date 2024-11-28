import 'dart:async';

import 'package:atv08_sl/model/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'package:dio/dio.dart';

import '../model/note.dart';

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();

  final Dio _dio = Dio();

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection("notes");

  String uid = "default";

  GenericCrudProvider._createInstance();

/*
  Map<String, Note> database = {};
  Future<Note> getNote(String noteId) async {}
  Future<String> insertNote(Note note) async {}
  Future<String> updateNote(String noteId, Note note) async {}
  Future<String> deleteNote(String noteId) async {}
  Future<List<Note>> getNoteList() async {}
*/

  Future<Note> getNote(String noteId) async {
    DocumentSnapshot response =
        await noteCollection.doc(uid).collection("my_notes").doc(noteId).get();

    Note note = Note.fromMap(response.data());
    note.noteId = noteId;
    return note;
  }

  Future<String> insertNote(Note note) async {
    noteCollection.doc(uid).collection("my_notes").add(note.toMap());
    return '1';
  }

  Future<String> updateNote(String noteId, Note note) async {
    noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc(noteId)
        .update(note.toMap());
    return noteId;
  }

  Future<String> deleteNote(String noteId) async {
    noteCollection.doc(uid).collection("my_notes").doc(noteId).delete();
    return noteId;
  }

  Future<List<Note>> getNoteList() async {
    QuerySnapshot querySnapshot =
        await noteCollection.doc(uid).collection("my_notes").get();
    List<Note> noteList = [];

    for (var doc in querySnapshot.docs) {
      Note note = Note.fromMap(doc.data());
      note.noteId = doc.id;
      noteList.add(note);
    }
    return noteList;
  }

  /*
    Parte da Stream
  */
  StreamController? _controller;

  notify(String noteId) async {
    _controller?.sink.add(noteId);
  }

  NoteCollection _noteListFromSnapshot(QuerySnapshot snapshot) {
    NoteCollection noteCollection = NoteCollection();
    for (var doc in snapshot.docs) {
      Note note = Note.fromMap(doc.data());
      noteCollection.insertNoteOfId(doc.id, note);
    }
    return noteCollection;
  }

  Stream get stream {
    return noteCollection
        .doc(uid)
        .collection("my_notes")
        .snapshots()
        .map(_noteListFromSnapshot);
  }
}
