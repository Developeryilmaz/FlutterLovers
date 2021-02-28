import 'package:flutter/material.dart';
import 'package:flutter_lovers/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _personModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          ElevatedButton(onPressed: () => _userExit(context: context), child: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(_personModel.person.profileURL),
            Text(_personModel.person.userName),
            Text(_personModel.person.email),
            Text(
              _personModel.person.createdAt.day.toString() + '/' + _personModel.person.createdAt.month.toString() + '/' + _personModel.person.createdAt.year.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _userExit({BuildContext context}) async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    bool result = await _personModel.signOut();
    return result;
  }
}
