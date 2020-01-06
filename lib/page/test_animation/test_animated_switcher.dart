import 'package:flutter/material.dart';

/// * Create by lf 2020-01-06 16:52
/// 通用'切换动画'组件
/// TODO AnimatedSwitcher
/// AnimatedSwitcher可以同时对其新、旧子元素添加显示、隐藏动画。
/// 也就是说在AnimatedSwitcher的子元素发生变化时，会对其旧元素和新元素
/// 当AnimatedSwitcher的child发送变化时(类型或key不同)，旧child会执行隐藏动画，新child会执行显示动画。
/// 究竟执行何种动画效果则由transitionBuilder参数决定，该参数接受一个AnimationSwitcherTransitionBuilder类型的builder
/// 该builder在AnimatedSwitcher的child切换时会分别对新、旧child绑定动画：
/// 1.对旧child，绑定的动画会反向执行(reverse)
/// 2.对新child，绑定的动画会正向执行(forward)
/// 这样一下，便实现了对新、旧child的动画绑定。
/// 默认情况下，AnimatedSwitcher会对新旧child执行'渐隐'和'渐显'动画。
/// TODO AnimatedSwitcher 实现原理： 因其继承自StatefulWidget，故具体做法是在didUpdateChange回调中判断其新旧child是否发现变化，发送变化则新旧执行相应的动画，具体看源码的实现。
/// 当然AnimatedSwitcher真正实现比这个复杂，这里只是说明它实现的核心逻辑
///
/// TODO AnimatedCrossFade
/// AnimatedCrossFade是针对两个子元素，而AnimatedSwitcher是在一个子元素的新旧值之间切换。
/// 具体可以查看AnimatedCrossFade源码
///
/// TODO AnimatedSwitcher高级用法
/// 假设现在我们想实现一个类似路由平移切换的动画： 旧页面屏幕中向左侧平移退出，新页面重屏幕右侧平移进入。
/// 如果要用AnimatedSwitcher的话，我们很快就会发现一个问题：做不到！
/// 我们前面说过在AnimatedSwitcher的child切换时会分别对新child执行正向动画（forward），
/// 而对旧child执行反向动画（reverse），所以真正的效果便是：新child确实从屏幕右侧平移进入了，但旧child却会从屏幕右侧（而不是左侧）退出。
/// 其实也很容易理解，因为在没有特殊处理的情况下，同一个动画的正向和逆向正好是相反（对称）的。
/// 究其原因，就是因为同一个Animation正向（forward）和反向（reverse）是对称的。所以如果我们可以打破这种对称性，那么便可以实现这个功能了

/// AnimatedSwitcher示例：实现一个计数器，然后再每一次自增的过程中，旧数字执行缩小动画隐藏，新数字执行放大动画显示

class TestAnimatedSwitcherRoute extends StatefulWidget {
  TestAnimatedSwitcherRoute({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestAnimatedSwitcherRouteState();
}

class _TestAnimatedSwitcherRouteState extends State<TestAnimatedSwitcherRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通用'切换动画'组件(AnimatedSwitcher)"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                // 执行缩放动画
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                "$_count",

                /// TODO 注意：AnimatedSwitcher的新旧child，如果类型相同，则Key必须不相等。
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                // 效果是“0”从左侧滑出，而“1”从右侧滑入。
                // 可以看到，我们通过这种巧妙的方式实现了类似路由进场切换的动画，
                // 实际上Flutter路由切换也正是通过AnimatedSwitcher来实现的。
                return MySlideTransition(
                  child: child,
                  position: tween.animate(animation),
                );
              },
              child: Text(
                "$_count",
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: Text("+1"),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 封装一个MySlideTransition，它与SlideTransition唯一的不同就是对动画的反向执行进行了定制
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    // 动画反向执行时，调整x偏移，实现"从左边滑出隐藏"
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
