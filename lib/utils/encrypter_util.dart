import 'dart:convert';
import 'package:encrypt/encrypt.dart';

import 'package:secure_string/secure_string.dart';

class EncrypterUtil{
  Encrypter _encrypter;
  String _passwordSeperate = "|||";
  EncrypterUtil(String key){
    var basePass = base64.encode(utf8.encode(key));
    if (basePass.length < 32) {
      basePass = "${basePass}JA8jtT0kMsqddwykw76RAMrSWCVrsmDL";
    }
    _encrypter = new Encrypter(new AES(basePass.substring(0, 32)));
  }
  String encrypt(String text) {
    var p = "$text$_passwordSeperate";
    var padding =
    new SecureString().generateAlphaNumeric(length: (32 - (p.length % 32)));
    return _encrypter.encrypt("$p$padding");
  }

  String decrypt(String text) {
    var p = _encrypter.decrypt(text);
    if(p.indexOf(_passwordSeperate)<0){
      return null;
    }
    return p.substring(0, p.lastIndexOf(_passwordSeperate));
  }

}