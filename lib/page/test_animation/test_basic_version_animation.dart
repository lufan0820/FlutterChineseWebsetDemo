import 'package:flutter/material.dart';

/// * Create by lf 2020-01-03 17:17
/// 动画基本结构
/// 下面实现了一个基础版本的动画
/// TODO 动画状态监听
/// 通过Animation的addStatusListener()方法来添加动画状态改变监听器。
/// TODO AnimationStatus
/// dismissed => 动画在起始点停止
/// forward => 动画正在正向执行
/// reverse => 动画正在反向执行
/// completed => 动画在终点停止

class TestBasicVersionAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestBasicVersionAnimationRouteState();
}

/// 需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _TestBasicVersionAnimationRouteState
    extends State<TestBasicVersionAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    // 使用弹性曲线(如果指定Curve，默认放大过程是线性的(匀速))
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片宽高从0到100
    animation = Tween(begin: 0.0, end: 100.0).animate(animation);
    animation.addListener(() {
      setState(() {});
    });
    // 通过添加动画状态监听事件，来改变动画执行
    /// 我们将上面图片放大的示例改为先放大再缩小再放大……这样的循环动画。
    /// 要实现这种效果，我们只需要监听动画状态的改变即可，
    /// 即：在动画正向执行结束时反转动画，在动画反向执行结束时再正向执行动画。
    animation.addStatusListener(listenStatus);
    // 启动动画(正向执行)
    controller.forward();
  }

  void listenStatus(status) {
    if (status == AnimationStatus.completed) {
      // 动画执行结束时反向执行动画
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      // 动画恢复到初始状态时执行动画(正向)
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("基础版本的动画实现")),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                if (animation.value >= 100 || animation.value <= 0) {
                  animation.addStatusListener(listenStatus);
                  if (animation.value == 100)
                    controller.reverse();
                  else
                    controller.forward();
                } else {
                  animation.removeStatusListener(listenStatus);
                }
              },
              child: Text("START/STOP"),
            ),
            Builder(builder: (context) {
              return Image.asset(
                "images/sia_girl.png",
                width: animation.value,
                height: animation.value,
              );
            }),
            // 使用AnimatedWidget重构上面的结构
            Container(
              margin: EdgeInsets.only(top: 30),
              child: AnimatedImage(animation: animation),
            ),
            // 使用AnimatedBuilder重构AnimatedImage
            // 看起来child被指定了2次
            // 但实际发生的事情是：将外部引用child传递给AnimatedBuilder后AnimatedBuilder再将其传递给匿名构造器，然后将该对象用作其子对象。
            // 最终的结果是AnimatedBuilder返回的对象插入到widget树中。
            /// 以下这种做法会带来三个好处:
            /// 1.不用显示的取添加帧监听器，然后再调用setState()了，这个好处和AnimatedImage是一样的。
            /// 2.动画构建的范围缩小了，如果没有builder，setState将会在父组件上下文中调用，这将会导致父组件的build方法重新调用，而有了builder之后
            /// 只会导致动画widget自身的build重新调用，避免不必要的rebuild。、
            /// 3.通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
            Container(
              margin: EdgeInsets.only(top: 30),
              child: AnimatedBuilder(
                animation: animation,
                child: Image.asset("images/sia_girl.png"),
                builder: (context, child) {
                  return Center(
                    child: Container(
                      height: animation.value,
                      width: animation.value,
                      child: child,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: GrowTransition(
                child: Image.asset("images/sia_girl.png"),
                animation: animation,
              ),
            )
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

/// 使用AnimatedWidget重构
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "images/sia_girl.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

/// 封装一个放大动画
/// Flutter正是通过这种方式封装了很多动画，如：
/// TODO FadeTransition、ScaleTransition、SizeTransition
/// 很多时候都可以复用这些预置的过渡类。
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
