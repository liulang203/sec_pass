import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountState createState() => new _AddAccountState();
}

class _AddAccountState extends State<AddAccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Acount"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.crop_free), onPressed: null),
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: "Enter Your Account Name",
                labelText: "Account Name:",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.multiline,
              decoration: new InputDecoration(
                hintText: "Tag",
                labelText: "Tag:",
              ),
            ),
            new TextField(
              obscureText: true,
              decoration: new InputDecoration(
                  hintText: "Password", labelText: "Password:"),
            ),
            new Center(
              child: new RaisedButton(
                onPressed: null,
                textTheme: ButtonTextTheme.primary,
                child: new Text("Add Account"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
