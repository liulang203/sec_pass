import 'package:flutter_test/flutter_test.dart';
import 'package:sec_pass/service/sec_account_service.dart';

void main() {
  test("sec account service test", () {
    var sas = new SecAccountService();
    sas.initEncrypter("中文测试");
    var text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit ........";
    var encry = sas.encrypt(text);
    print("encrypt data:${encry}");
    expect(text, sas.decrypt(encry));

    sas.initEncrypter("昨夜西风凋碧树，独上高楼，望尽天涯路。");
    text = "Lorem ipsum dolor sit";
    encry = sas.encrypt(text);
    print("encrypt data:${encry}");
    expect(text, sas.decrypt(encry));
  });
}
