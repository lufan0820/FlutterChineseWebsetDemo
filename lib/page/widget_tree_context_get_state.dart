import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 17:04
/// 在Widget树中获取State对象
/// 1.通过Context

class TestWidgetContextGetState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetContextGetState();
}

class _TestWidgetContextGetState extends State<TestWidgetContextGetState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // 查找父级最近的Scaffold对应的ScaffoldState对象
              ScaffoldState _state =
                  context.findAncestorStateOfType<ScaffoldState>();
              // 直接通过of静态方法来获取ScaffoldState
              // ScaffoldState _state = Scaffold.of(context);
              // 调用ScaffoldState的showSnackBar弹出SnackBar
              _state.showSnackBar(SnackBar(content: Text("我是SnackBar")));
            },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}
