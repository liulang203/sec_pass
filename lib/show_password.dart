import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';

class ShowPasswordPage extends StatefulWidget {
  const ShowPasswordPage({
    this.uid,
    this.stateKey,
  });

  final int uid;
  final GlobalKey<ScaffoldState> stateKey;

  @override
  _ShowPasswordState createState() => new _ShowPasswordState();
}

class _ShowPasswordState extends State<ShowPasswordPage> {
  final SecAccountService _secAccountService = SecAccountService();
  String _showPasswordStr="*******";
  String _password;

  @override
  void initState() {
    super.initState();
    _readPassword();
  }
  void _readPassword() async{
    SecAccount acc = await _secAccountService.findOne(widget.uid);
    _password = _secAccountService.showPassword(acc.password);
  }


//check the password is success
  void _showPassword() {
      setState(() {
        _showPasswordStr=_password;
      });

  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Password"),
      content: new Text("Pass:$_showPasswordStr"),
      actions: <Widget>[
        new RaisedButton.icon(
          onPressed: _showPassword,
          icon: new Icon(Icons.details),
          label: new Text("Detail"),
        ),
        new RaisedButton.icon(
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: _password));
            widget.stateKey.currentState.showSnackBar(new SnackBar(
              content: new Text("Copied to Clipboard"),
              duration: new Duration(seconds: 2),
            ));
          },
          icon: new Icon(Icons.content_copy),
          label: new Text("Copy"),
        ),
      ],
    );
  }
}
