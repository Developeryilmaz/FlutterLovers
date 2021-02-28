

import 'package:flutter_lovers/model/person.dart';

abstract class AuthBase {
  Future<Person> currentUser();
  Future<Person> sigInAnonymously();
  Future<bool> signOut();
  Future<Person> signInWithGoogle();
  Future<Person> signInWithFacebook();
  Future<Person> signInWithEmail(String email, String password);
  Future<Person> createPersonWithEmail(String email, String password);
}