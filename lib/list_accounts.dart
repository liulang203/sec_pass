import 'package:flutter/material.dart';
import 'app_login.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/data/db_helper.dart';

/// Opens an [AlertDialog] showing what the user typed.
class ListAccountPage extends StatefulWidget {
  @override
  _ListAccountPageState createState() => new _ListAccountPageState();
}

/// State for [PasswordListWidget] widgets.
class _ListAccountPageState extends State<ListAccountPage> {
  final TextEditingController _controller = new TextEditingController();
  final DbHelper _dbHelper= DbHelper();
  final List<SecAccount> _accounts= [];
  @override
  Widget build(BuildContext context) {
    _searchAccounts();
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
                  builder: (context) => loginPage,
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
          final index = i ~/ 2;
          if(index<_accounts.length) {
            return _listDetail(_accounts[index]);
          }

        },
      ),
    );
  }
  Widget _listDetail(SecAccount account){
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(title: new Text("${account.username}"),
    subtitle: new Text("${account.tag}"),),
        new ButtonBar(
          children: <Widget>[
            new IconButton(icon: new Icon(Icons.pageview),color: Colors.blueAccent, onPressed: null),
            new IconButton(icon: new Icon(Icons.edit),color: Colors.blueAccent, onPressed: null),
            new IconButton(icon: new Icon(Icons.delete),color: Colors.deepOrangeAccent, onPressed: null),

          ],
        )
      ],
    );
  }

  /// add  new account info
  void _accountAdd() {
    Navigator.of(context).pushNamed("/addAccount");
  }
  void _searchAccounts() async{
    List<SecAccount> lists = await  _dbHelper.search(_controller.value.text);
    _accounts.clear();
    _accounts.addAll(lists);

  }
}
