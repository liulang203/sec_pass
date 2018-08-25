import 'dart:async';

import 'package:sec_pass/data/db_helper.dart';
import 'package:sec_pass/models/sec_account.dart';
import 'package:sec_pass/utils/encrypter_util.dart';

class SecAccountService {
  EncrypterUtil _encrypter = null;
  DbHelper _dbHelper = DbHelper();

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
    account.password = encrypt(account.password);
    account.updatedDate=DateTime.now();
    var res = await _dbHelper.updatePassword(account);
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

    EncrypterUtil encrypter = new EncrypterUtil(key);
    List<SecAccount> accounts = await _dbHelper.all();
    if (accounts.isNotEmpty) {
      print("account is not empty, check the accounts password");
      try {
        if(encrypter.decrypt(accounts.first.password) == null){
          return false;
        }
        print("check the password success");
      } catch (e) {
        return false;
      }
    }
    this._encrypter = encrypter;
    return true;
  }

  bool isSetEncrypter() {
    return this._encrypter != null;
  }

  String encrypt(String text) {

    return _encrypter.encrypt(text);
  }

  String decrypt(String text) {
    return _encrypter.decrypt(text);
  }

  Future<SecAccount> findOne(int id) async {
    return await _dbHelper.findByPk(id);

  }

  Future<int> deleteAccount(int id) async {
   return await _dbHelper.delete(id);
  }
}
