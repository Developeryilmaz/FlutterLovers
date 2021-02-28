import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Person {
  final String userID;
  String email;
  String userName;
  String profileURL;
  DateTime createdAt;
  DateTime updatedAt;
  int level;

  Person({@required this.userID, @required this.email, @required this.userName, @required this.profileURL});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName ?? email.substring(0, email.indexOf('@')) + createdRandomNumber(),
      'profileURL': profileURL ?? 'https://graph.facebook.com/416727566296557/picture',
      'createdAt': createdAt ?? Timestamp.now(),
      'updatedAt': updatedAt ?? Timestamp.now(),
      'level': level ?? 1,
    };
  }

  Person.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profileURL = map['profileURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        level = map['level'];

  @override
  String toString() {
    return 'Person{userID: $userID, email: $email, userName: $userName, profileURL: $profileURL, createdAt: $createdAt, updatedAt: $updatedAt, level: $level}';
  }

  String createdRandomNumber() {
    int randomNumber = Random().nextInt(999999);
    return randomNumber.toString();
  }
}
