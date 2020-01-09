import 'package:flutter/material.dart';

import 'my_event_bus.dart';

/// * Create by lf 2019-12-31 16:43
/// 模拟登录成功之后，发布事件

class TestEventLoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录")),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(ModalRoute.of(context).settings.arguments),
            Padding(padding: EdgeInsets.only(top: 15)),
            RaisedButton(
              onPressed: () {
                bus.emit("login", "我是登录页面的数据");
                Navigator.pop(context);
              },
              child: Text("登录"),
            ),
          ],
        ),
      ),
    );
  }
}
