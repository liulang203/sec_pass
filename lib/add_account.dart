import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';
import 'package:barcode_scan/barcode_scan.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountState createState() => new _AddAccountState();
}

class _AddAccountState extends State<AddAccountPage> {
  var _nameCtl = new TextEditingController();
  var _tagCtl = new TextEditingController();
  var _pwdCtl = new TextEditingController();
  var _formState = new GlobalKey<FormState>();
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
      } catch (e) {
        print(e);
        return;
      }
      _formState.currentState.reset();
      _nameCtl.value = new TextEditingValue(text: "");
      _tagCtl.value = new TextEditingValue(text: "");
      _pwdCtl.value = new TextEditingValue(text: "");
    }
  }

  void _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (barcode.startsWith("PWD;;;")) {
        var infos = barcode.split(";;;");
        if (infos.length > 3) {
          setState(() {
            print("content is success:${barcode}");
            _nameCtl.value = new TextEditingValue(text: infos[1]);
            _tagCtl.value = new TextEditingValue(text: infos[2]);
            _pwdCtl.value = new TextEditingValue(text: infos[3]);
          });
        }
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          print('The user did not grant the camera permission!');
        });
      } else {
        setState(() => print('Unknown error: $e'));
      }
    } on FormatException {
      setState(() => print(
          'null (User returned using the "back"-button before scanning anything. Result)'));
    } catch (e) {
      setState(() => print('Unknown error: $e'));
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.crop_free),
              onPressed: () {
                _scan();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Form(
                  key: _formState,
                  autovalidate: false,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        controller: _nameCtl,
                        onSaved: (String val) => _acc.username = val,
                        validator: _validateAccountName,
                        decoration: new InputDecoration(
                          hintText: "Enter Your Account Name",
                          labelText: "Account Name:",
                        ),
                      ),
                      new TextFormField(
                        controller: _tagCtl,
                        onSaved: (String val) => _acc.tag = val,
                        validator: _validateTag,
                        decoration: new InputDecoration(
                          hintText: "Tag",
                          labelText: "Tag:",
                        ),
                      ),
                      new TextFormField(
                        controller: _pwdCtl,
                        onSaved: (String val) => _acc.password = val,
                        validator: _validatePassword,
                        obscureText: true,
                        decoration: new InputDecoration(
                            hintText: "Password", labelText: "Password:"),
                      ),
                    ],
                  ),
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
            )),
      ),
    );
  }
}
