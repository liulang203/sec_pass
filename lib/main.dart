import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Security Password',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PasswordListWidget(),
    );
  }
}


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
              icon: new Icon(Icons.search)
          ),
          new IconButton(
              onPressed: _passwordAdd,
              icon: new Icon(Icons.person_add)
          ),
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        return new ListTile(
          title: new Text("list title ${i.toString()}"),
        );
      },
      ),
    );
  }
  void _passwordAdd(){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add New Acount"),
        ),
        body: new Text("this is test"),
      );
    }));
  }
}
