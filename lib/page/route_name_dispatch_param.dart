import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 14:41
/// 命名路由传递参数

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取路由的参数
    var args = ModalRoute.of(context).settings.arguments;
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.height,
      color: Colors.blueAccent,
      margin: EdgeInsets.fromLTRB(0, 100.0, 0, 100.0),
      child: Text("我是路由的参数: $args",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 14.0,
          )),
    );
  }
}
