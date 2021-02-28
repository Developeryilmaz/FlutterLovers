import 'package:flutter/material.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/screens/signin/email_login_register.dart';
import 'package:flutter_lovers/screens/widgets/loading_container.dart';
import 'package:flutter_lovers/screens/widgets/social_login_button.dart';
import 'package:flutter_lovers/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    final _personModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Page'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        color: Colors.blue.withOpacity(0.1),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Oturum Ac',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SocialLoginButton(
              text: 'Gmail ile giris yap',
              textColor: Colors.black87,
              icon: Image.asset('assets/images/google-logo.png'),
              onPressed: () => _signInWithGoogle(context: context),
            ),
            SocialLoginButton(
              text: 'Facebook ile giris yap',
              color: Colors.blue,
              icon: Image.asset('assets/images/facebook-logo.png'),
              onPressed: () => signInWithFacebook(context: context),
            ),
            SocialLoginButton(
              text: 'Email ile giris yap',
              color: Colors.purple,
              icon: Icon(Icons.attach_email, size: 32, color: Colors.white),
              onPressed: () => _signInWithEmail(context: context),
            ),
            loadingContainer(context: context,opacity: _personModel.state == ViewState.Idle ? 0 : 1)
          ],
        ),
      ),
    );
  }
/*
  void _guestSign({BuildContext context}) async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    Person person = await _personModel.sigInAnonymously();
    if (person != null) print('sign user id : ' + person.userID.toString());
  }*/

  void signInWithFacebook({BuildContext context}) async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    Person person = await _personModel.signInWithFacebook();
    if (person != null) print('sign user id : ' + person.userID.toString());
  }

  void _signInWithGoogle({BuildContext context}) async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    Person _person = await _personModel.signInWithGoogle();
    if (_person != null) print('sign user id : ' + _person.userID.toString());
  }

  void _signInWithEmail({BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute(fullscreenDialog: true, builder: (context) => EmailLoginRegister()));
  }
}
