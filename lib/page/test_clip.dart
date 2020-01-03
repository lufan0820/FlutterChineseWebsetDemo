import 'package:flutter/material.dart';

/// * Create by lf 2019-12-24 10:40
/// 裁剪
///
/// TODO ClipOval
/// 子组件为正方形时裁剪为内贴圆形，为矩形时，裁剪为内贴椭圆
///
/// TODO ClipRRect
/// 将子组件裁剪为圆角矩形
///
/// TODO ClipRect
/// 裁剪子组件到实际占用的矩形大小(溢出部分裁剪)

class TestClipRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/sia_girl.png", width: 100);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("裁剪(Clip)"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              avatar, // 不裁剪
              ClipOval(child: avatar), // 裁剪为圆形
              // 裁剪为圆角矩形
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: avatar,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, // 宽度设为原来的一半，另一半会溢出
                    child: avatar,
                  ),
                  Text(
                    "你好世界",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 将溢出的部分裁剪掉
                  ClipRect(
                    child: Align(
                      alignment: Alignment.topLeft,
                      widthFactor: .5, // 宽度设为原来的一半，另一半会溢出
                      child: avatar,
                    ),
                  ),
                  Text(
                    "你好世界",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: ClipRect(
                  clipper: MyClipper(),
                  child: avatar,
                ),
              ),
            ].map((e) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: e,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// 自定义裁剪的区域
class MyClipper extends CustomClipper<Rect> {
  // 获取裁剪区域的接口
  @override
  Rect getClip(Size size) => Rect.fromLTWH(25, 25, 50, 50);

  // 是否重新裁剪
  // 如果裁剪区域没有发生变化，那么应该返回false，避免无必要的性能开销
  // 发生变化的话(比如: 裁剪区域执行了旋转动画/平移动画等),那么应该返回true，重新裁剪
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
