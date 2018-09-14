import 'package:flutter/material.dart';
import 'dart:async';
import 'app_login.dart';
import 'update_password.dart';
import 'show_password.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/service/sec_account_service.dart';

/// Opens an [AlertDialog] showing what the user typed.
class ListAccountPage extends StatefulWidget {
  @override
  _ListAccountPageState createState() => new _ListAccountPageState();
}

/// State for [PasswordListWidget] widgets.
class _ListAccountPageState extends State<ListAccountPage> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  final SecAccountService _secAccountService = SecAccountService();
  final List<SecAccount> _accounts = [];
  final loginPage = new LoginPage();

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<Null> _refreshList() async {
    List<SecAccount> lists =
        await _secAccountService.search(_controller.value.text);
    setState(() {
      _accounts.clear();
      _accounts.addAll(lists);
    });

    return new Future.value(null);
  }

  void _searchAccounts() async {
    await _refreshList();
  }

  /// add  new account info
  void _accountAdd() {
    if (_validateAccount()) {
      Navigator.of(context).pushNamed("/addAccount");
    }
  }

  void _viewAccountDetail(int id) async {
    if (_validateAccount()) {
      showDialog(
        context: context,
        builder: (context) {
          return new ShowPasswordPage(
            uid: id,
            stateKey: key,
          );
        },
      );
    }
  }

  void _editAccountPasswd(int id) async {
    if (_validateAccount()) {
      showDialog(
        context: context,
        builder: (context) => new UpdatePasswordPage(uid: id),
      );
    }
  }

  void _deleteAccount(int id) {
    if (_validateAccount()) {
      showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
              title: new Text("Confirm Delete Account"),
              content: new ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.cancel),
                      iconSize: 48.0,
                      onPressed: () {
                        Navigator.pop(context, true);
                      }),
                  new IconButton(
                      icon:
                          new Icon(Icons.check, color: Colors.deepOrangeAccent),
                      iconSize: 48.0,
                      onPressed: () async {
                        int num = await _secAccountService.deleteAccount(id);
                        if (num > 0) {
                          _refreshList();
                          Navigator.pop(context, true);
                        }
                      }),
                ],
              ));
        },
      );
    }
  }

  bool _validateAccount() {
    if (!_secAccountService.isSetEncrypter()) {
      showDialog(
        context: context,
        builder: (context) => loginPage,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: key,
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
        body: new RefreshIndicator(
          child: new ListView(
            children: _listItems(),
          ),
          onRefresh: _refreshList,
        ));
  }

  List<Widget> _listItems() {
    var items = <Widget>[];
    for (int i = 0; i < _accounts.length; i++) {
      items.add(_listDetail(_accounts[i]));
      items.add(new Divider());
    }
    return items;
  }

  Widget _listDetail(SecAccount account) {
    var res = new Row(
      children: <Widget>[
        new Expanded(
            child: new ListTile(
          title: new Text("${account.username}"),
          subtitle: new Text("${account.tag}"),
        )),
        new IconButton(
            icon: new Icon(Icons.pageview),
            color: Colors.blueAccent,
            onPressed: () {
              _viewAccountDetail(account.id);
            }),
        new IconButton(
            icon: new Icon(Icons.edit),
            color: Colors.blueAccent,
            onPressed: () {
              _editAccountPasswd(account.id);
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              _deleteAccount(account.id);
            }),
      ],
    );
    return res;
  }
}
