import 'package:flutter/material.dart';
import 'add_account.dart';
import 'list_accounts.dart';
import 'app_login.dart';
import 'themes.dart';

void main() => runApp(new MyApp());

final routes = {
  '/addAccount': (BuildContext context) => new AddAccountPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new ListAccountPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Security Password',
      theme: themes,
      routes: routes,
    );
  }
}
