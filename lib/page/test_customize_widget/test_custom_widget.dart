import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

import 'test_custom_gradient_button.dart';

/// * Create by lf 2020-01-09 16:19
/// 自定义组件
/// 示例1：自定义渐变按钮GradientButton

class TestCustomWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestCustomWidgetRouteState();
}

class _TestCustomWidgetRouteState extends State<TestCustomWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义组件")),
      body: Container(
        child: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50,
              child: Text("Submit"),
              onPressed: () => onTap("Submit"),
            ),
            GradientButton(
              colors: [Colors.lightGreen, Colors.green[700]],
              height: 50,
              child: Text("Send"),
              onPressed: () => onTap("Send"),
            ),
            GradientButton(
              colors: [Colors.lightBlue[300], Colors.blueAccent],
              height: 50,
              child: Text("Revert"),
              onPressed: () => onTap("Revert"),
            ),
          ],
        ),
      ),
    );
  }

  onTap(String text) => showToast(text);
}
