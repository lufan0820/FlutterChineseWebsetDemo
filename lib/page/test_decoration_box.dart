import 'package:flutter/material.dart';

/// * Create by lf 2019-12-23 15:19
/// 装饰容器
/// TODO DecoratedBox
/// DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等
///
/// TODO BoxDecoration
/// 它是一个Decoration的子类，实现了常用的装饰元素的绘制
/// 详见: https://book.flutterchina.club/chapter5/decoratedbox.html

class TestSomeDecorationBoxRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("装饰容器"),
      ),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            // 背景渐变
            // LinearGradient 线性渐变
            // 还有其他的如: RadialGradient SweepGradient
            // 详见API文档
            gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
            borderRadius: BorderRadius.circular(3.0), // 3.0的圆角
            boxShadow: [
              // 阴影
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width - 95) / 2,
              vertical: 15.0,
            ),
            child: Container(
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
