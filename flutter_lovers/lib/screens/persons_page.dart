import 'package:flutter/material.dart';
import 'package:flutter_lovers/screens/example1.dart';

class PersonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Example1(),
                  )),
              child: Icon(Icons.padding))
        ],
      ),
      body: Center(
        child: Text('Persons Page'),
      ),
    );
  }
}
