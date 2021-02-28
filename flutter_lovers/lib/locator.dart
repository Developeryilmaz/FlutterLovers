import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/firestore_services/firestore_db_service.dart';
import 'package:flutter_lovers/services/sign_services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FireStoreDBService());
  locator.registerLazySingleton(() => UserRepository());
}