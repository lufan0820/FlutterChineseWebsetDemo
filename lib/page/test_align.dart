import 'package:flutter/material.dart';

/// * Create by lf 2019-12-22 14:52
/// 对齐与相对定位
/// TODO Align
/// Align组件可以调整子组件的位置，并且可以根据子组件的宽度来确定自身的宽高
///
/// TODO alignment
/// 需要一个AlignmentGeometry类型的值，表示子组件在父组件中的起始位置。
/// AlignmentGeometry 是一个抽象类，它有两个常用的子类：
/// Alignment和 FractionalOffset
///
/// TODO widthFactor和heightFactor
/// 是用于确定Align 组件本身宽高的属性；
/// 它们是两个缩放因子，会分别乘以子元素的宽、高，最终的结果就是Align 组件的宽高。
/// 如果值为null，则组件的宽高将会占用尽可能多的空间。
///
/// TODO Alignment
/// 继承自AlignmentGeometry,表示矩形内的一个点，
/// 他有两个属性x、y，分别表示在水平和垂直方向的偏移
/// Alignment会以矩形的中心点作为坐标的原点,即Alignment(0.0,0.0)
/// Alignment可以通过其坐标转换公式将其坐标转为子元素的具体偏移坐标
/// TODO  坐标转换公式: (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
/// childWidth为子元素的宽度，childHeight为子元素高度
///
/// TODO FractionalOffset
/// 继承自Alignment，与Alignment唯一的区别就是坐标原点不同！
/// FractionalOffset坐标原点为矩形的左侧顶点
/// TODO 坐标转换公式:  实际偏移 = (FractionalOffset.x * childWidth, FractionalOffset.y * childHeight)
///
/// TODO Align和Stack的对比
/// 都可以用于指定子元素相对于父元素的偏移，它们之间的主要区别:
/// 1.定位的参考系不同
///   1.1 Stack/Positioned 定位的参考系可以是父容器的4个点
///   而Align则需要先通过alignment参数来确定坐标原点,不同的alignment对应不同的原点,最终的偏移需要通过换算公式计算得出的
/// 2.Stack可以有多个子元素堆叠，而Align只能有一个子元素
///
/// TODO Center
/// 继承自Align
/// 少了一个alignment参数；
/// 通过源码得知Center的构造函数中 alignment值为Alignment.center，
/// 所以我们可以认为Center组件其实是对齐方式确定(Alignment.center)了的Align
///

class TestAlignRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("对齐与相对定位"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              margin: const EdgeInsets.all(10),
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.topRight,
                // FlutterLogo 是官方提供的一个显示Flutter商标的组件
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            ),
            // 不指定宽度和高度
            // 利用widthFactor和heightFactor也能达到上面的效果
            Container(
              color: Colors.blue[50],
              margin: EdgeInsets.only(bottom: 10),
              child: Align(
                widthFactor: 2,
                heightFactor: 2,
                alignment: Alignment.topRight,
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            ),
            Container(
              color: Colors.blue[50],
              margin: EdgeInsets.only(bottom: 10),
              child: Align(
                widthFactor: 2,
                heightFactor: 2,
                alignment: Alignment(2, 0.0), // 换算成坐标为(90,30)
                child: FlutterLogo(size: 60),
              ),
            ),
            Container(
              height: 120,
              width: 120,
              margin: EdgeInsets.only(bottom: 10),
              color: Colors.blue[50],
              child: Align(
                alignment: FractionalOffset(0.2, 0.6), // 换算成坐标(12,36)
                child: FlutterLogo(size: 60),
              ),
            ),
            Container(
              color: Colors.blue[50],
              margin: EdgeInsets.only(bottom: 10),
              height: 120,
              width: 120,
              child: Center(
                child: FlutterLogo(size: 60),
              ),
            ),
            // 上面说widthFactor 或 heightFactor 为null时，
            // 组件的宽高将会占用可能多的空间，这一点需要特别注意
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text("Hello World"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Text("Hello World"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
