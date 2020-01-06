import 'package:flutter/material.dart';

/// * Create by lf 2020-01-06 15:37
/// 交织动画
/// 交织动画需要注意一下几点：
/// 1.要创建交织动画，需要使用多个动画对象(Animation)
/// 2.一个AnimationController控制所有的动画对象。
/// 3.给每一个动画对象指定时间间隔(Interval)
///
/// 下面实现一个例子：
/// 1.开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这过程占据整个动画时间的60%
/// 2.高度增长到300后，开始沿X轴向右平移100像素；这个过程占据整个动画时间的40%
///

class TestInterWeaveAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestInterWeaveAnimationRouteState();
}

class _TestInterWeaveAnimationRouteState
    extends State<TestInterWeaveAnimationRoute> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 初始化AnimationController
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    // 执行动画
    try {
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // 动画可能被取消，因为当前路由可能被销毁(dispose)了
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("交织动画")),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _playAnimation(),
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // 调用我们定义的交织动画widget
            child: StaggerAnimation(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// 我们将执行动画的widget分离出来
/// StaggerAnimation分别定义了三个动画，分别对应Container的height、color、padding 属性设置的动画，
/// 然后通过Interval来为每个动画指定在整个动画过程中的起始点和终点。
class StaggerAnimation extends StatelessWidget {
  // 构造函数
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    // 高度动画
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6, // 间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    // 颜色动画
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6, // 间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    // X轴平移动画
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: 0.0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6,
          1.0, // 间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  final AnimationController controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
