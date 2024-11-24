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

  Future<ProfileContent?> get() async {
    DocumentSnapshot response = await profileCollection.doc(uid).get();

    notify(ProfileContent.fromMap(response.data()));
    return ProfileContent.fromMap(response.data());
  }

  Future<String> insert(ProfileContent profileContent) async {
    profileCollection.doc(uid).set(profileContent.toMap());
    return uid;
  }

  Future<String> update(ProfileContent profileContent) async {
    profileCollection.doc(uid).update(profileContent.toMap());
    return uid;
  }

  Future<String> delete() async {
    profileCollection.doc(uid).delete();
    return uid;
  }

  StreamController _controller = StreamController.broadcast();

  notify(ProfileContent profile) async {
    _controller.sink.add(profile);
  }

  Stream get stream {
    return _controller.stream;
  }

  toggleFavorite(String locationId) {
    update(ProfileContent.self!.toggleFavorite(locationId));
  }
}
