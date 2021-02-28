import 'package:flutter_lovers/model/person.dart';

abstract class DBBase {
  Future<bool> savePerson(Person person);
  Future<Person> readPerson(String userID);
}
