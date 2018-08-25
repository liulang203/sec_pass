import 'package:flutter/material.dart';
import 'password_field.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    this.uid,
  });

  final int uid;

  @override
  _UpdatePasswordState createState() => new _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePasswordPage> {
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
  void _savePassword() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      bool res = await _secAccountService.upatePassword(new SecAccount(id: widget.uid,password: password));
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
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                      onPressed:(){ Navigator.pop(context, true);},
                      icon: new Icon(Icons.cancel),
                      label: new Text("Cancel"),
                    ),
                    new RaisedButton.icon(
                      onPressed: _savePassword,
                      icon: new Icon(Icons.save),
                      label: new Text("Save"),
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
