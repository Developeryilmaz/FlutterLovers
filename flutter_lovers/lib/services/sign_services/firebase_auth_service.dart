import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/services/sign_services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Person> currentUser() async {
    try {
      User user = _firebaseAuth.currentUser;
      return _convertPerson(user);
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> FirebaseAuthService - currentUser');
      return null;
    }
  }

  Person _convertPerson(User user) {
    if (user != null) return Person(userID: user.uid, email: user.email, profileURL: user.photoURL, userName: user.displayName);
    return null;
  }

  @override
  Future<Person> sigInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      return _convertPerson(userCredential.user);
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> FirebaseAuthService - sigInAnonymously');
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final _facebookLogin = FacebookLogin();
      await _googleSignIn.signOut();
      await _facebookLogin.logOut();
      return true;
    } catch (e) {
      print('\nThis Error .......=> ' + '\n$e' + '\n -> FirebaseAuthService - signOut');
      return false;
    }
  }

  @override
  Future<Person> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.accessToken != null && _googleAuth.idToken != null) {
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: _googleAuth.idToken,
          idToken: _googleAuth.idToken,
        ));
        /*
        print('---------------------- signInWithGoogle ----------------------------------');
        print('displayName : '+userCredential.user.displayName);
        print('email : '+userCredential.user.email);
        //print('phoneNumber : '+userCredential.user.phoneNumber);
        print('photoURL : '+userCredential.user.photoURL);
        print('----------------------- signInWithGoogle ---------------------------------');

         */
        User user = userCredential.user;
        Person _person = _convertPerson(user);
        return _person;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Person> signInWithFacebook() async {
    final _facebookLogin = FacebookLogin();
    FacebookLoginResult _facebookLoginResult = await _facebookLogin.logIn(['public_profile', 'email']);
    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_facebookLoginResult.accessToken != null) {
          UserCredential _userCredential = await _firebaseAuth.signInWithCredential(FacebookAuthProvider.credential('${_facebookLoginResult.accessToken.token}'));
          print(_userCredential.user.photoURL.toString());
          return _convertPerson(_userCredential.user);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Use did cancel facebook login -> FirebaseAuthService - signInWithFacebook');
        break;
      case FacebookLoginStatus.error:
        print('\nThis Error .......=> ' + '\n${_facebookLoginResult.errorMessage}' + '\n -> FirebaseAuthService - signInWithFacebook');
        break;
    }
    return null;
  }

  @override
  Future<Person> createPersonWithEmail(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return _convertPerson(userCredential.user);
  }

  @override
  Future<Person> signInWithEmail(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return _convertPerson(userCredential.user);
  }
}
