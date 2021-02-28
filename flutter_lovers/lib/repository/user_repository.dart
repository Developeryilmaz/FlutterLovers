import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/services/firestore_services/firestore_db_service.dart';
import 'package:flutter_lovers/services/sign_services/auth_base.dart';
import 'package:flutter_lovers/services/sign_services/firebase_auth_service.dart';

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FireStoreDBService _dbService = locator<FireStoreDBService>();

  @override
  Future<Person> currentUser() async {
    return await _firebaseAuthService.currentUser();
  }

  @override
  Future<Person> sigInAnonymously() async {
    return await _firebaseAuthService.sigInAnonymously();
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  @override
  Future<Person> signInWithGoogle() async {
    Person person = await _firebaseAuthService.signInWithGoogle();
    bool result = await _dbService.savePerson(person);
    if (result)
      return await _dbService.readPerson(person.userID);
    else
      return null;
  }

  @override
  Future<Person> signInWithFacebook() async {
    Person person = await _firebaseAuthService.signInWithFacebook();
    bool result = await _dbService.savePerson(person);
    if (result)
      return await _dbService.readPerson(person.userID);
    else
      return null;
  }

  @override
  Future<Person> createPersonWithEmail(String email, String password) async {
    Person person = await _firebaseAuthService.createPersonWithEmail(email, password);
    bool result = await _dbService.savePerson(person);
    if (result) {
      return await _dbService.readPerson(person.userID);
    } else {
      return null;
    }
  }

  @override
  Future<Person> signInWithEmail(String email, String password) async {
    Person person = await _firebaseAuthService.signInWithEmail(email, password);
    return await _dbService.readPerson(person.userID);
  }
}
