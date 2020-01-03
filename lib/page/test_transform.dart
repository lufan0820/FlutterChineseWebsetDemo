import 'dart:math' as math;

import 'package:flutter/material.dart';

/// * Create by lf 2019-12-23 15:41
/// 变换
/// TODO Transform
/// Transform 可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效
/// Transform的变换是在应用绘制阶段，而不是应用布局(layout)阶段
/// 所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
///
/// TODO RotatedBox
/// RotatedBox和Transform.rotate功能相似,它们都可以对子组件进行旋转变化
/// 但是有一点不同:
/// RotatedBox的变换是在layout阶段，会影响子组件的位置和大小

class TestTransformRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("变换"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
              color: Colors.black,
              child: Transform(
                alignment: Alignment.topRight, // 相对于坐标系原点的对齐方式
                transform: Matrix4.skewY(0.3), // 沿Y轴倾斜0.3的弧度
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: Text("Apartment for rent!"),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              // 默认原点为左上角，左移20像素，向上平移5像素
              child: Transform.translate(
                offset: Offset(-20.0, -5.0),
                child: Text("Hello World!"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              // 旋转90度
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Text("Hello World!"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                scale: 1.5, // 放大到1.5倍
                child: Text("Hello World!"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                  scale: 1.5,
                  child: Text("Hello World!"),
                ),
              ),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: RotatedBox(
                    quarterTurns: 1, // 旋转90度(1/4圈)
                    child: Text("Hello World!"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(fontSize: 18.0, color: Colors.green),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
