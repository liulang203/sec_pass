import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'dart:convert';

import 'package:sec_pass/utils/encrypter_util.dart';
void main() {
  test("test encrypter util", () {
  EncrypterUtil sas = new EncrypterUtil("中文测试");
  var text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit ........";
  var encry = sas.encrypt(text);
  print("encrypt data:$encry");
  expect(text, sas.decrypt(encry));

  sas = new EncrypterUtil("昨夜西风凋碧树，独上高楼，望尽天涯路。");
  text = "Lorem ipsum dolor sit";
  encry = sas.encrypt(text);
  print("encrypt data:$encry");
  expect(text, sas.decrypt(encry));

  text = "中文测试";
  encry = sas.encrypt(text);
  print("encrypt data:$encry");
  expect(text, sas.decrypt(encry));
  });
  test("utf code ",(){
    var text = "中文测试";
    final input = Uint8List.fromList(utf8.encode(text));
    final out = utf8.decode(input);
    expect(text, out);
  });
}