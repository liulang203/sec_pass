import 'package:flutter/material.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountState createState() => new _AddAccountState();
}

class _AddAccountState extends State<AddAccountPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = new GlobalKey();
    SecAccount _acc = new SecAccount();
    SecAccountService _service = SecAccountService();

    String _validateAccountName(String val) {
      if (val.length < 5) {
        return 'Please Input The Account Name';
      }
      return null;
    }

    String _validateTag(String val) {
      if (val.length < 2) {
        return 'Please Input The Tag';
      }
      return null;
    }

    String _validatePassword(String val) {
      if (val.length < 2) {
        return 'Please Input The Password';
      }
      return null;
    }

    void _submit() async {
      if (_formState.currentState.validate()) {
        _formState.currentState.save();
        try {
         await _service.saveAccount(_acc);
        }catch(e){
          print(e);
          return;
        }
        _formState.currentState.reset();
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Acount"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.crop_free), onPressed: null),
        ],
      ),
      body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Form(
            key: _formState,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  onSaved: (String val)=>_acc.username=val,
                  validator: _validateAccountName,
                  decoration: new InputDecoration(
                    hintText: "Enter Your Account Name",
                    labelText: "Account Name:",
                  ),

                ),
                new TextFormField(
                  onSaved: (String val)=>_acc.tag=val,
                  validator: _validateTag,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    hintText: "Tag",
                    labelText: "Tag:",
                  ),
                ),
                new TextFormField(
                  onSaved: (String val)=>_acc.password=val,
                  validator: _validatePassword,
                  obscureText: true,
                  decoration: new InputDecoration(
                      hintText: "Password", labelText: "Password:"),
                ),
                new ButtonBar(
                  children: <Widget>[
                    new RaisedButton(
                      onPressed: _submit,
                      textTheme: ButtonTextTheme.primary,
                      child: new Text("Add Account"),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
