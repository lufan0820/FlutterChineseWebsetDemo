import 'package:flutter/material.dart';

/// * Create by lf 2020-01-03 17:17
/// 动画基本结构
/// 下面实现了一个基础版本的动画

class TestBasicVersionAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestBasicVersionAnimationRouteState();
}

/// 需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _TestBasicVersionAnimationRouteState
    extends State<TestBasicVersionAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // 使用弹性曲线(如果指定Curve，默认放大过程是线性的(匀速))
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片宽高从0到3
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });
    // 启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("基础版本的动画实现")),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if (animation.value >= 300) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
            child: Text("执行动画(宽高从0到300,正/反向执行)"),
          ),
          Image.asset(
            "images/sia_girl.png",
            width: animation.value,
            height: animation.value,
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
