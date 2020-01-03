import 'dart:convert';

/// * Create by lf 2019-12-25 13:39

/// 对手机号做星号处理(位数必须要大于5位)
String delAccount(String account) {
  var newAccount = "";
  int len = account.length;
  if (len > 5) {
    String xingType = "****";
    int start = (len - xingType.length) ~/ 2;
    if (len % 2 == 0) {
      newAccount = account.replaceRange(start, start + 4, xingType);
    } else {
      newAccount = account.replaceRange(start + 1, start + 5, xingType);
    }
    return newAccount;
  }
  return account;
}

/// TODO JSON 数据解析
void anyaJson(String strJson) {
  String str = "[{" +
      "\t\"id\": 1,\n" +
      "\t\"fullName\": \"xlq\",\n" +
      "\t\"phone\": \"13545654580\",\n" +
      "\t\"address_label\": 1,\n" +
      "\t\"fullAddress\": \"fewfew,note:fewf\",\n" +
      "\t\"shipDefault\": false,\n" +
      "\t\"billDefault\": true\n" +
      "}]";
  List jsonList = jsonDecode(str);
  print(jsonList.length);
  jsonList.forEach((e) {
    Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
    jsonMap.forEach((key, value) {
      print("$key : $value");
    });
  });
}
