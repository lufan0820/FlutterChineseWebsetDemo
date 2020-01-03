import 'package:flutter/material.dart';

/// * Create by lf 2019-12-24 14:01
/// 可滚动组件
/// TODO SingleChildScrollView
/// 类似于android中的ScrollView，它只能接受一个子组件
/// 具体属性见相关文档
/// 通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，
/// 这是因为SingleChildScrollView不支持基于Sliver的延迟实例化模型，
/// 所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用SingleChildScrollView将会非常昂贵（性能差），
/// 此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView
///

class TestSingleChildScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScrollView"),
      ),
      // 父级套上Scrollbar，会显示滚动条，IOS上会自动切换成CupertinoScrollbar
      body: Scrollbar(
          child: SingleChildScrollView(
        // 拉倒顶/底部的效果
        // 默认在安卓下使用的是 ClampingScrollPhysics 微光效果
        // iOS下是  BouncingScrollPhysics 弹性效果
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            // 动态创建一个List<Widget>
            children: str
                .split("")
                .map(
                  (text) => Text(
                    text,
                    textScaleFactor: 2,
                  ),
                )
                .toList(),
          ),
        ),
      )),
    );
  }
}
