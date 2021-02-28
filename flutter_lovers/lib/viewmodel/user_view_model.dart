import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/sign_services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  String passwordErrorMessage;
  String emailErrorMessage;
  UserRepository _userRepository = locator<UserRepository>();
  ViewState _state = ViewState.Idle;
  Person _person;

  Person get person => _person;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  @override
  Future<Person> currentUser() async {
    try {
      state = ViewState.Busy;
      _person = await _userRepository.currentUser();
      state = ViewState.Idle;
      return _person;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> UserViewModel - currentUser');
      state = ViewState.Idle;
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Person> sigInAnonymously() async {
    try {
      state = ViewState.Busy;
      _person = await _userRepository.sigInAnonymously();
      return _person;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> UserViewModel - sigInAnonymously');
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool result = await _userRepository.signOut();
      _person = null;
      return result;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> UserViewModel - signOut');
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Person> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _person = await _userRepository.signInWithGoogle();
      return _person;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> UserViewModel - signInWithGoogle');
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Person> signInWithFacebook() async {
    try {
      state = ViewState.Busy;
      _person = await _userRepository.signInWithFacebook();
      return _person;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> UserViewModel - signInWithGoogle');
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Person> createPersonWithEmail(String email, String password) async {
    state = ViewState.Busy;
    if (_emailPasswordController(email, password)) {
      state = ViewState.Busy;
      _person = await _userRepository.createPersonWithEmail(email, password);
      state = ViewState.Idle;
      return _person;
    } else {
      state = ViewState.Idle;
      return null;
    }
  }

  @override
  Future<Person> signInWithEmail(String email, String password) async {
    state = ViewState.Busy;
    if (_emailPasswordController(email, password)) {
      state = ViewState.Busy;
      _person = await _userRepository.signInWithEmail(email, password);
      state = ViewState.Idle;
      return _person;
    } else {
      state = ViewState.Idle;
      return null;
    }
  }

  bool _emailPasswordController(String email, String password) {
    var result = true;
    if (!email.contains('@')) {
      emailErrorMessage = 'Mail adresi mail formatinda olmali';
      return false;
    } else {
      emailErrorMessage = null;
    }
    if (password.length < 6) {
      passwordErrorMessage = 'Sifre en az 6 karakter olmali';
      return false;
    } else {
      passwordErrorMessage = null;
    }

    return result;
  }
}
