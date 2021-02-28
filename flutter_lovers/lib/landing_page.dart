import 'package:flutter/material.dart';
import 'package:flutter_lovers/screens/homepage.dart';
import 'package:flutter_lovers/screens/signin/sign_in_page.dart';
import 'package:flutter_lovers/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _personModel = Provider.of<UserViewModel>(context);
      if (_personModel.person == null) return SignInPage();
      return HomePage(person: _personModel.person);
  }
}
