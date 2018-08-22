import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:sec_pass/data/db_helper.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:secure_string/secure_string.dart';

class SecAccountService {
  Encrypter _encrypter = null;
  DbHelper _dbHelper = DbHelper();
  String _passwordSeperate = "|||";
  static final SecAccountService _instance = new SecAccountService._internal();

  factory SecAccountService() => _instance;

  SecAccountService._internal();

  Future<bool> saveAccount(SecAccount account) async {
    var password = account.password;
    account.password = encrypt(password);
    account.createdDate=DateTime.now();
    account.updatedDate=DateTime.now();
    var res = await _dbHelper.saveSecAccount(account);
    if (res < 1) {
      account.password = password;
    }
    return res > 0;
  }

  Future<bool> upatePassword(SecAccount account) async {
    var password = account.password;
    account.password = encrypt(password);
    account.updatedDate=DateTime.now();
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
    condition="%${condition}%";
    return _dbHelper.search(condition);
  }

  Future<bool> initEncrypter(String key) async {
    var basePass = base64.encode(utf8.encode(key));
    if (basePass.length < 32) {
      basePass = "${basePass}JA8jtT0kMsqddwykw76RAMrSWCVrsmDL";
    }
    Encrypter encrypter = new Encrypter(new AES(basePass.substring(0, 32)));
    List<SecAccount> accounts = await _dbHelper.all();
    if (accounts.isNotEmpty) {
      try {
        encrypter.decrypt(accounts.first.password);
      } catch (e) {
        return false;
      }
    }
    this._encrypter = encrypter;
    return true;
  }

  bool isSetEncrypter() {
    print(this._encrypter);
    return this._encrypter != null;
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

  Future<SecAccount> findOne(int id) async {
    return await _dbHelper.findByPk(id);

  }
}
