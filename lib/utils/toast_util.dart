import 'package:fluttertoast/fluttertoast.dart';

/// * Create by lf 2019-12-13 10:52

class ToastUtil {
  static void showMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }
}

showToast(String msg) {
  ToastUtil.showMsg(msg);
}
