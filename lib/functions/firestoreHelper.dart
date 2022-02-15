import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstprojectiwm/model/User.dart';
import 'package:firstprojectiwm/view/inscription.dart';
import 'package:flutter/foundation.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("Users");
  final firestorage = FirebaseStorage.instance;

  //Méthodes
  Future CreationUser({String? mail, String? password, String? nom, String? prenom}) async {
    UserCredential authresult = await auth.createUserWithEmailAndPassword(email: mail!, password: password!);
    User? user = authresult.user!;
    String uid = user.uid;

    Map<String,dynamic> map = {
      "PRENOM": prenom,
      "NOM": nom,
      "MAIL": mail,
    };

    addUser(uid, map);
  }

  Future ConnectUser({required String mail, required String password}) async {
    UserCredential authresult = await auth.signInWithEmailAndPassword(email: mail, password: password);
    User? user = authresult.user!;
  }


  addUser(String uid, Map<String,dynamic> map) {
    fire_user.doc(uid).set(map);
  }

  updateUser(String uid, Map<String,dynamic> map) {
    fire_user.doc(uid).update(map);
  }

  deleteUser(String uid) {
    fire_user.doc(uid).delete();
  }

  logUser() {
    auth.signOut();
  }

  Future <String> getIdentifiant() async {
    String uid = "";
    uid = auth.currentUser!.uid; // le ! permet de forcer l'uid qui est à l'origine optionnel
    return uid;
  }

  Future <Users> getUser(String uid) async {
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();
    return Users(snapshot);
  }

  Future <String>stockageImage(String nonImage, Uint8List data) async {
    TaskSnapshot download = await firestorage.ref("cover/$nonImage").putData(data);
    String urlChemin = await download.ref.getDownloadURL();
    return urlChemin;
  }

}
