import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/services/firestore_services/database_base.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> savePerson(Person person) async {
    if (person != null) {
      await _firestore.collection('users').doc(person.userID).set(person.toMap());
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.doc('users/${person.userID}').get();
      Map _personMap = documentSnapshot.data();
      Person _person = Person.fromMap(_personMap);
      print("Read person is objects : " + _person.toString());
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Person> readPerson(String userID) async {
    DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(userID).get();
    Map<String, dynamic> personMap = documentSnapshot.data();
    Person person = Person.fromMap(personMap);
    print('Read person is info : ' + person.toString());
    return person;
  }
}
