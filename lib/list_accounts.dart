import 'package:flutter/material.dart';
import 'dart:async';
import 'app_login.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';

/// Opens an [AlertDialog] showing what the user typed.
class ListAccountPage extends StatefulWidget {
  @override
  _ListAccountPageState createState() => new _ListAccountPageState();
}

/// State for [PasswordListWidget] widgets.
class _ListAccountPageState extends State<ListAccountPage> {
  var refreshKey= new GlobalKey<RefreshIndicatorState>();
  final TextEditingController _controller = new TextEditingController();
  final SecAccountService _secAccountService = SecAccountService();
  final List<SecAccount> _accounts = [];
  final loginPage = new LoginPage();

  @override
  void initState(){
    super.initState();
    _refreshList();
  }

  Future<Null> _refreshList() async{
    refreshKey.currentState.show(atTop: false);
    List<SecAccount> lists =
    await _secAccountService.search(_controller.value.text);
    _accounts.clear();
    _accounts.addAll(lists);
    return null;
  }
  void _searchAccounts() async{
    await _refreshList();
  }


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
              onPressed: _searchAccounts, icon: new Icon(Icons.search)),
          new IconButton(
              onPressed: _accountAdd, icon: new Icon(Icons.person_add)),
        ],
      ),
      body: new RefreshIndicator(child:  new ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index < _accounts.length) {
            return _listDetail(_accounts[index]);
          }
        },
      ),
        onRefresh: _refreshList,
      )
    );
  }

  Widget _listDetail(SecAccount account) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          title: new Text("${account.username}"),
          subtitle: new Text("${account.tag}"),
        ),
        new ButtonBar(
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.pageview),
                color: Colors.blueAccent,
                onPressed: null),
            new IconButton(
                icon: new Icon(Icons.edit),
                color: Colors.blueAccent,
                onPressed: null),
            new IconButton(
                icon: new Icon(Icons.delete),
                color: Colors.deepOrangeAccent,
                onPressed: null),
          ],
        )
      ],
    );
  }

  /// add  new account info
  void _accountAdd() {
    if (!_secAccountService.isSetEncrypter()) {
      showDialog(
        context: context,
        builder: (context) => loginPage,
      );
    } else {
      Navigator.of(context).pushNamed("/addAccount");
    }
  }

}
