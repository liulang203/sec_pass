import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:sec_pass/data/db_helper.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:secure_string/secure_string.dart';

class SecAccountService {
  Encrypter _encrypter;
  DbHelper _dbHelper = DbHelper();
  String _passwordSeperate = "|||";

  Future<bool> saveAccount(SecAccount account) async {
    var password = account.password;
    account.password = encrypt(password);
    var res = await _dbHelper.saveSecAccount(account);
    if (res < 1) {
      account.password = password;
    }
    return res > 0;
  }

  Future<bool> upatePassword(SecAccount account) async {
    var password = account.password;
    account.password = encrypt(password);
    var res = await _dbHelper.updatePassword(account);
    if (res < 1) {
      account.password = password;
    }
    return res > 0;
  }

  String showPassword(String password) {
    return decrypt(password);
  }

  Future<List<SecAccount>> search(String condition) async {
    if (condition == '') {
      return await _dbHelper.all();
    }
    return _dbHelper.search(condition);
  }

  void initEncrypter(String key) {
    var basePass = base64.encode(utf8.encode(key));
    if (basePass.length < 32) {
      basePass = "${basePass}JA8jtT0kMsqddwykw76RAMrSWCVrsmDL";
    }
    _encrypter = new Encrypter(new AES(basePass.substring(0, 32)));
  }

  bool isSetEncrypter() {
    return _encrypter == null;
  }

  String encrypt(String text) {
    var p = "${text}${_passwordSeperate}";
    var padding =
        new SecureString().generateAlphaNumeric(length: (32 - (p.length % 32)));
    return _encrypter.encrypt("${p}${padding}");
  }

  String decrypt(String text) {
    var p = _encrypter.decrypt(text);
    return p.substring(0, p.lastIndexOf(_passwordSeperate));
  }
}
