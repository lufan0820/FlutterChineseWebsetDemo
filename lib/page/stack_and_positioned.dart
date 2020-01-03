import 'package:flutter/material.dart';

/// * Create by lf 2019-12-20 16:43
/// 层叠布局
/// TODO Stack+Positioned
/// 层叠布局和Web中的绝对定位、Android中的Frame布局是相似的，
/// 子组件可以根据距父容器四个角的位置来确定自身的位置。
/// 绝对定位允许子组件堆叠起来（按照代码中声明的顺序）。
/// Flutter中使用Stack和Positioned这两个组件来配合实现绝对定位。
/// Stack允许子组件堆叠，而Positioned用于根据Stack的四个角来确定子组件的位置

class StackAndPositionedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("层叠布局"),
      ),
      // 通过ConstrainedBox来确保Stack沾满屏幕
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, // 未指定定位或部分定位widget的对齐方式
          fit: StackFit.expand, // 未定位widget沾满整个空间
          children: <Widget>[
            // 因为Stack是堆叠的，所以第一个Positioned会被第二个组件Container遮住
            Positioned(
              child: Text("I am jack 111"),
              left: 20.0,
            ),
            Container(
              child: Text(
                "Hello World! 111",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              child: Text("I am rose 111"),
              top: 20.0,
            ),
            Positioned(
              child: Text("I am jack 111"),
              left: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
