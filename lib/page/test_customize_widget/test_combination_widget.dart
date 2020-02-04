import 'package:flutter/material.dart';

/// * Create by lf 2020-02-04 13:57
/// 组合组件
/// 实例：TurnBox
/// 可以任意角度来旋转其子节点，角度发生变化时
/// 执行一个动画以过渡到新状态，同时我们可以手动指定动画速度。

class TurnBox extends StatefulWidget {
  const TurnBox(
      {Key key,
      this.turns = .0, // 旋转的'圈'数，一圈为360度，如0.25圈即90度
      this.speed = 200, // 过渡动画执行的总时长
      this.child})
      : super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _TurnBoxState();
}

/// 1.通过组合RotationTransition和child来实现的旋转效果
/// 2.在didUpdateWidget中，我们判断要旋转的角度是否发生了变化，如果变化了，则执行一个过渡动画
class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }
}

class TestCombinationWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestCombinationWidgetRouteState();
}

class _TestCombinationWidgetRouteState
    extends State<TestCombinationWidgetRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("组合组件")),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(
                Icons.refresh,
                size: 150.0,
              ),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
