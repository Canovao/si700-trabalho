import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';

class ProfileContentProvider {
  static ProfileContentProvider helper =
      ProfileContentProvider._createInstance();

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection("profiles");

  String uid = "default";

  ProfileContentProvider._createInstance();

  void get() async {
    DocumentSnapshot response = await profileCollection.doc(uid).get();
    ProfileContent.self = ProfileContent.fromMap(response.data());
  }

  Future<String> insert(ProfileContent profileContent) async {
    profileCollection.doc(uid).set(profileContent.toMap());
    return uid;
  }

  Future<String> update(ProfileContent profileContent) async {
    profileCollection.doc(uid).update(profileContent.toMap());
    get();
    return uid;
  }

  Future<String> delete() async {
    profileCollection.doc(uid).delete();
    return uid;
  }

  StreamController? _controller;

  notify(String noteId) async {
    _controller?.sink.add(noteId);
  }

  ProfileContent? _noteListFromSnapshot(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
      if (doc.id == uid) {
        return ProfileContent.fromMap(doc.data());
      }
    }
    return null;
  }

  Stream get stream {
    return profileCollection.snapshots().map(_noteListFromSnapshot);
  }
}
