import 'package:flutter/material.dart';
import 'password_field.dart';
import 'package:sec_pass/service/sec_account_service.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SecAccountService _secAccountService = SecAccountService();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String password;

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please Input Password';
    }
    return null;
  }

//check the password is success
  void _checkPassword() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      bool res = await _secAccountService.initEncrypter(password);
      if (res) {
        Navigator.pop(context, true);
      } else {
        print("init password fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text('Enter The Password'),
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: new Form(
            key: _formKey,
            autovalidate: false,
            child: new Column(
              children: <Widget>[
                new PasswordField(
                  helperText: 'No more than 32 characters.',
                  maxLength: 32,
                  labelText: 'Password *',
                  validator: _validatePassword,
                  onSaved: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                new ButtonBar(
                  children: <Widget>[
                    new RaisedButton.icon(
                      onPressed: _checkPassword,
                      icon: new Icon(Icons.spellcheck),
                      label: new Text("Login"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
