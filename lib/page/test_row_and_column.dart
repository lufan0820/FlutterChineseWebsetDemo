import 'package:flutter/material.dart';

/// * Create by lf 2019-12-20 10:23
/// 线性布局（Row和Column）
/// TODO 主轴和纵轴
/// 对于线性布局，有主轴和纵轴之分，
/// 如果布局是沿水平方向，那么主轴就是指水平方向，而纵轴即垂直方向；
/// 如果布局沿垂直方向，那么主轴就是指垂直方向，而纵轴就是水平方向。
/// 在线性布局中，有两个定义对齐方式的枚举类MainAxisAlignment和CrossAxisAlignment，分别代表主轴对齐和纵轴对齐
///
/// TODO textDirection：
/// 表示水平方向子组件的布局顺序(是从左往右还是从右往左)，
/// 默认为系统当前Locale环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)
///
/// TODO mainAxisSize
/// 表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，
/// 表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度；
/// 而MainAxisSize.min表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则Row的实际宽度等于所有子组件占用的的水平空间；
/// TODO mainAxisAlignment
/// 表示子组件在Row所占用的水平空间内对齐方式，
/// 如果mainAxisSize值为MainAxisSize.min，
/// 则此属性无意义，因为子组件的宽度等于Row的宽度。
/// 只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义，
/// MainAxisAlignment.start表示沿textDirection的初始方向对齐，
/// 如textDirection取值为TextDirection.ltr时，则MainAxisAlignment.start表示左对齐，
/// textDirection取值为TextDirection.rtl时表示从右对齐。
/// 而MainAxisAlignment.end和MainAxisAlignment.start正好相反；
/// MainAxisAlignment.center表示居中对齐。
/// textDirection是mainAxisAlignment的参考系。
///
/// TODO verticalDirection
/// 表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down，表示从上到下。
///
/// TODO crossAxisAlignment
/// 表示子组件在纵轴方向的对齐方式，Row的高度等于子组件中最高的子元素高度，
/// 它的取值和MainAxisAlignment一样(包含start、end、 center三个值)，
/// 不同的是crossAxisAlignment的参考系是verticalDirection，
/// 即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，
/// verticalDirection值为VerticalDirection.up时，crossAxisAlignment.start指底部对齐；
/// 而crossAxisAlignment.end和crossAxisAlignment.start正好相反；
///
/// TODO children
/// 子组件数组
///

class TestRowAndColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局（Row和Column）"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          // 测试Row对齐方式,排除Column默认居中对齐的干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              // 居中对齐
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("hello world  "),
                Text("I`m LF"),
              ],
            ),
            Row(
              // mainAxisSize为MainAxisSize.min,所以mainAxisAlignment对齐毫无意义
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("hello world  "),
                Text("I`m LF"),
              ],
            ),
            Row(
              // textDirection: TextDirection.rtl 子组件会从右向左顺序排列，mainAxisAlignment为end 所以左边对齐显示
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text("hello world  "),
                Text("I`m LF  "),
              ],
            ),
            Row(
              // verticalDirection: VerticalDirection.up,从底向顶排列，crossAxisAlignment 为start 所以底部对齐显示
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  "hello world  ",
                  style: TextStyle(fontSize: 24.0),
                ),
                Text("I`m LF"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("hi"),
                Text("world"),
              ],
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity), // 使宽度占用尽可能多的空间
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("hi"),
                  Text("world"),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ColumnRoute();
                }));
              },
              child: Text("Column嵌套"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ColumnRoute2();
                }));
              },
              child: Text("Column嵌套"),
            )
          ],
        ),
      ),
    );
  }
}

class ColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column嵌套"),
      ),
      body: Container(
        // 线性布局嵌套
        // 只有对最外面的Row或Column会占用尽可能大的空间，
        // 里面Row或Column所占用的空间为实际大小
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, // 有效,外层Column高度为整个屏幕
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.max, // 无效，内层Column高度为实际高度
                  children: <Widget>[
                    Text("hello world"),
                    Text("I`m LF"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column嵌套"),
      ),
      body: Container(
        // 线性布局嵌套
        // 只有对最外面的Row或Column会占用尽可能大的空间，
        // 里面Row或Column所占用的空间为实际大小
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, // 有效,外层Column高度为整个屏幕
            children: <Widget>[
              // 让里面的Column沾满外部的Column,可以使用Expanded组件
              Expanded(
                  child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("hello world"),
                    Text("I`m LF"),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
