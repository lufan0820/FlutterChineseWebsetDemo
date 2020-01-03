import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 16:29
/// 显示字符串的公共组件
/// 按照惯例，widget的构造函数参数应使用命名参数，
/// 命名参数中的必要参数要添加@required标注，这样有利于静态代码分析器进行检查。
/// 另外，在继承widget时，第一个参数通常应该是Key，
/// 另外，如果Widget需要接收子Widget，那么child或children参数通常应被放在参数列表的最后。
/// 同样是按照惯例，Widget的属性应尽可能的被声明为final，防止被意外改变

class EchoWidget extends StatelessWidget {
  const EchoWidget(
      {Key, key, @required this.text, this.backgroundColor: Colors.grey})
      : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(
          text,
          textScaleFactor: 2,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
