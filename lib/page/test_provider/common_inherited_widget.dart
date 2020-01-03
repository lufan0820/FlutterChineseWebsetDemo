import 'package:flutter/material.dart';

/// * Create by lf 2019-12-25 16:57
// 定义一个通用的InheritedWidget
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  // 共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    // 在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}
