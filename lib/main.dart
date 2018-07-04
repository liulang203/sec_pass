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
      home: new ExampleWidget(),
    );
  }
}


/// Opens an [AlertDialog] showing what the user typed.
class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key key}) : super(key: key);

  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState();
}

/// State for [ExampleWidget] widgets.
class _ExampleWidgetState extends State<ExampleWidget> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('What you typed'),
                    content: new Text(_controller.text),
                  ),
                );
              },
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
}
