import 'package:flutter/material.dart';

/// * Create by lf 2019-12-22 16:10
/// 填充
/// TODO Padding
///

class TestPaddingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("填充(Padding)"),
      ),
      body: Padding(
        // 上下左右各添加16像素补白
        padding: EdgeInsets.all(16.0),
        child: Column(
          // 指定对齐方式，排除对齐干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              // 左边添加8像素补白
              padding: const EdgeInsets.only(left: 8),
              child: Text("Hello World"),
            ),
            // 上下各添加8像素补白
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("I`m LF"),
            ),
            // 分别指定4各方向的补白
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
              child: Text("Your Friend"),
            ),
          ],
        ),
      ),
    );
  }
}
