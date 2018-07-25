import 'package:flutter/material.dart';

/// Opens an [AlertDialog] showing what the user typed.
class PasswordListWidget extends StatefulWidget {
  PasswordListWidget({Key key}) : super(key: key);

  @override
  _PasswordListWidgetState createState() => new _PasswordListWidgetState();
}

/// State for [PasswordListWidget] widgets.
class _PasswordListWidgetState extends State<PasswordListWidget> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // There is a input Field for search the passwords
        title: new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            hintText: 'Search password',
          ),
        ),
        actions: <Widget>[
          new IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('What you typed'),
                    content: new Text(_controller.text),
                  ),
                );
              },
              icon: new Icon(Icons.search)),
          new IconButton(
              onPressed: _accountAdd, icon: new Icon(Icons.person_add)),
        ],
      ),
      body: new ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          return new ListTile(
            title: new Text("list title ${i.toString()}"),
          );
        },
      ),
    );
  }

  /// add  new account info
  void _accountAdd() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
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
                    hintText: "Password",
                    labelText: "Password:"
                ),
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
    }));
  }
}