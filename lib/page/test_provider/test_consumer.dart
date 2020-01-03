import 'package:flutter/material.dart';

import 'change_notifier_provider.dart';

/// * Create by lf 2019-12-26 10:50

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context, ChangeNotifierProvider.of<T>(context), // 自动获取Model
    );
  }
}
