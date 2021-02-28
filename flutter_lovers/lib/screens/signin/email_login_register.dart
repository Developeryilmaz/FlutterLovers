import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/screens/widgets/loading_container.dart';
import 'package:flutter_lovers/screens/widgets/social_login_button.dart';
import 'package:flutter_lovers/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

enum FormType { Register, LogIn }

class EmailLoginRegister extends StatefulWidget {
  @override
  _EmailLoginRegisterState createState() => _EmailLoginRegisterState();
}

class _EmailLoginRegisterState extends State<EmailLoginRegister> {
  String _email, _password;
  String _btnText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    final _personModel = Provider.of<UserViewModel>(context);
    _btnText = _formType == FormType.LogIn ? 'GIRIS YAP' : 'KAYIT OL';
    _linkText = _formType == FormType.LogIn ? 'Hesabaniz yok mu ? KAYIT OLUN' : 'Hesabiniz var mi ? GIRIS YAP';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login / Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 25, top: 25),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: _personModel.emailErrorMessage != null ? _personModel.emailErrorMessage : null,
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email',
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String email) {
                          _email = email.trim();
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          errorText: _personModel.passwordErrorMessage != null ? _personModel.passwordErrorMessage : null,
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Şifre',
                          labelText: 'Şifre',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String password) {
                          _password = password.trim();
                        },
                      ),
                      SizedBox(height: 5),
                      errorMessage != null
                          ? Text(
                              errorMessage,
                              style: TextStyle(color: Colors.pink),
                            )
                          : SizedBox(),
                      SizedBox(height: 8),
                      SocialLoginButton(text: _btnText, icon: Icon(Icons.email), onPressed: () => _formSubmit(), color: Colors.purple),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _changeLoginType,
                        child: Text(
                          _linkText,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.purple.shade50, side: BorderSide(color: Colors.purple.shade200, width: 1)),
                      ),
                      loadingContainer(context: context, opacity: _personModel.state == ViewState.Idle ? 0 : 1),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  _formSubmit() async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    _formKey.currentState.save();
    if (_formType == FormType.LogIn) {
      try {
        Person _person = await _personModel.signInWithEmail(_email.trim(), _password.trim());
        _personModel.state = ViewState.Idle;
        if (_person != null) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorMessage = 'Kullanıcı Bulunamadı';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Yanlış Şifre';
        }else if(e.code == 'ınvalıd-emaıl'){
          errorMessage = 'Yanlış mail format..';
        }
        _personModel.state = ViewState.Idle;
        return null;
      }
    } else {
      try {
        Person _person = await _personModel.createPersonWithEmail(_email.trim(), _password.trim());
        if (_person != null) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          errorMessage = 'Yanlış Şifre!...';
          setState(() {});
        } else if (e.code == 'emaıl-already-ın-use') {
          errorMessage = 'Bu mail adresi daha önceden alınmış';
          setState(() {});
        }else if(e.code == 'ınvalıd-emaıl'){
          errorMessage = 'Yanlış mail format..';
        }
        _personModel.state = ViewState.Idle;
        return null;
      }
    }
  }

  void _changeLoginType() {
    _formType = _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    setState(() {});
  }
}
