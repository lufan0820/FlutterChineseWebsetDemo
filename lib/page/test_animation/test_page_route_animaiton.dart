import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2020-01-06 10:42
/// 自定义路由切换动画
/// TODO PageRouteBuilder
/// 使用PageRouteBuilder来自定义路由切换动画
///
/// 我们可以看到pageBuilder 有一个animation参数，这是Flutter路由管理器提供的，
/// 在路由切换时pageBuilder在每个动画帧都会被回调，因此我们可以通过animation对象来自定义过渡动画。
/// 无论是MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承自PageRoute类，
/// 而PageRouteBuilder其实只是PageRoute的一个包装，我们可以直接继承PageRoute类来实现自定义路由

class TestPageAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("自定义路由切换动画")),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => _TestPageA()));
              },
              child: Text("IOS风格"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    // 动画时间为500毫秒
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        // 使用渐隐渐入过渡
                        opacity: animation,
                        child: _TestPageA(),
                      );
                    },
                  ),
                );
              },
              child: Text("渐隐渐入"),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.push(context, MyFadeRoute(builder: (context) {
                return _TestPageA();
              })),
              child: Text("渐隐渐入"),
            ),
          ].map((e) {
            return Padding(padding: const EdgeInsets.only(top: 10), child: e);
          }).toList(),
        ),
      ),
    );
  }
}

class _TestPageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PageA")),
      body: Center(
        child: Text("PageA", textScaleFactor: 2),
      ),
    );
  }
}

// 定义一个路由类MyFadeRoute
class MyFadeRoute extends PageRoute {
  MyFadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 当前路由被激活，是打开新路由
    if (isActive) {
      return FadeTransition(opacity: animation, child: builder(context));
    } else {
      // 是返回，则不应用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
