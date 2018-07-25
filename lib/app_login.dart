import 'package:flutter/material.dart';

final loginPage=new LoginPage();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
   return new SimpleDialog(
      title: new Text('What you typed'),
    );
  }
}
