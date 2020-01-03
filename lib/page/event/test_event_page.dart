import 'package:flutter/material.dart';

import 'my_event_bus.dart';

/// * Create by lf 2019-12-31 16:43
class TestEventPageRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestEventPageRouteState();
}

class _TestEventPageRouteState extends State<TestEventPageRoute> {
  String loginInfo = "";

  @override
  void initState() {
    super.initState();
    // 监听订阅的事件
    bus.on("testPage", (arg) {
      setState(() {
        loginInfo = arg;
      });
    });
    bus.on("login", (arg) {
      setState(() {
        loginInfo = arg;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 移除订阅的事件
    bus.off("TestPage");
    bus.off("login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("测试全局事件总线")),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "test_event_login",
                  arguments: "我是携带的参数"),
              child: Text("跳转登录并携带参数"),
            ),
            RaisedButton(
              onPressed: () {
                // 发布一个事件给本页面，测试时使用，实际开发没必要这么写。
                bus.emit("testPage", "我是发布的事件TestPage");
              },
              child: Text("给本页面发布一个事件"),
            ),
            Text(loginInfo, textScaleFactor: 2),
          ].map((e) {
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
