import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//final userr = FirebaseAuth.instance;


class UserModel {
  String uid;
  final String userName;
  final String email;
  final String Phone;
  String role;

  UserModel({
    this.uid = '',
    required this.userName,
    required this.email,
    required this.Phone,
    this.role = 'user',
  });

  toJson() {
    return {
      "uid" : uid,
      "Username": userName,
      "Email": email,
      "PhoneNo": Phone,
      "Role": role,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        uid: document.id,
        userName: data['Username'],
        email: data['Email'],
        Phone: data['PhoneNo'],
        role: data['Role'] ?? 'user',
    );
  }
}
