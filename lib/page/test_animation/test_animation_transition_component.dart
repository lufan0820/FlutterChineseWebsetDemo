import 'package:flutter/material.dart';

/// * Create by lf 2020-01-07 15:53
/// 动画过渡组件
/// TODO 自定义动画过渡组件
/// 实现一个AnimatedDecoratedBox，它可以在decoration属性发生变化时，从旧状态变成新状态的过程可以执行一个过渡动画。
/// TODO Flutter预置的动画过渡组件
/// AnimatedPadding => 在padding发生变化时会执行过渡动画到新状态
/// AnimatedPositioned => 配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
/// AnimatedOpacity => 在透明度opacity发生变化时执行过渡动画到新状态
/// AnimatedAlign => 当alignment发生变化时会执行过渡动画到新的状态。
/// AnimatedContainer => 当Container属性发生变化时会执行过渡动画到新的状态。
/// AnimatedDefaultTextStyle => 当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。

class TestAnimationTransitionComponentRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _TestAnimationTransitionComponentRouteState();
}

class _TestAnimationTransitionComponentRouteState
    extends State<TestAnimationTransitionComponentRoute> {
  Color _decorationColor1 = Colors.blue;
  Color _decorationColor2 = Colors.green;

  // 演示Flutter预置的动画过渡组件
  double _padding = 0;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  double _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 3);
    return Scaffold(
      appBar: AppBar(title: Text("自定义动画过渡组件")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // 实现按钮点击后，背景色从蓝色过渡到红色的效果
              // 封装动画，利用AnimationController来管理
              AnimatedDecoratedBox1(
                duration: Duration(
                    milliseconds:
                        _decorationColor1 == Colors.blue ? 2000 : 500),
                decoration: BoxDecoration(color: _decorationColor1),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _decorationColor1 = _decorationColor1 == Colors.blue
                          ? Colors.red
                          : Colors.blue;
                    });
                  },
                  child: Text(
                    "AnimatedDecoratedBox1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // 封装动画，采用的方式是分别继承ImplicitlyAnimatedWidget和ImplicitlyAnimatedWidgetState类
              AnimatedDecoratedBox2(
                duration: Duration(
                    milliseconds:
                        _decorationColor2 == Colors.green ? 2000 : 500),
                decoration: BoxDecoration(color: _decorationColor2),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _decorationColor2 = _decorationColor2 == Colors.green
                          ? Colors.yellow
                          : Colors.green;
                    });
                  },
                  child: Text(
                    "AnimatedDecoratedBox2",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _padding = 20;
                  });
                },
                child: AnimatedPadding(
                  padding: EdgeInsets.all(_padding),
                  duration: duration,
                  child: Text("AnimatedPadding"),
                ),
              ),
              SizedBox(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: duration,
                      left: _left,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _left = 120;
                          });
                        },
                        child: Text("AnimatedPositioned"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                color: Colors.grey,
                child: AnimatedAlign(
                  duration: duration,
                  alignment: _align,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _align = Alignment.center;
                      });
                    },
                    child: Text("AnimatedAlign"),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: duration,
                height: _height,
                color: _color,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _height = 150;
                      _color = Colors.blue;
                    });
                  },
                  child: Text(
                    "AnimatedContainer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                child: GestureDetector(
                  child: Text("hello world"),
                  onTap: () {
                    setState(() {
                      _style = TextStyle(
                        color: Colors.blue,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.blue,
                      );
                    });
                  },
                ),
                style: _style,
                duration: duration,
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: duration,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _opacity = 1;
                    });
                  },
                  child: Text("AnimatedOpacity"),
                ),
              )
            ].map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: e,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// 虽然实现了我们期望的功能，但是代码却比较复杂。
class AnimatedDecoratedBox1 extends StatefulWidget {
  AnimatedDecoratedBox1({
    Key key,
    @required this.decoration,
    this.child,
    this.curve = Curves.linear,
    @required this.duration,
    this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  State<StatefulWidget> createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );

    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null)
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    else
      _animation = _controller;
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// TODO 封装动画，分别继承ImplicitlyAnimatedWidget和ImplicitlyAnimatedWidgetState类即可，下面是演示代码：
/// 第一步继承ImplicitlyAnimatedWidget
class AnimatedDecoratedBox2 extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox2({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, // 动画曲线
    @required Duration duration, // 正向动画执行时长
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );

  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedDecorationBox2State();
}

/// 第二步 State类继承自AnimatedWidgetBaseState(该类继承自ImplicitlyAnimatedWidgetState)
class _AnimatedDecorationBox2State
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox2> {
  DecorationTween _decorationTween; // 定义一个Tween
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _decorationTween = visitor(_decorationTween, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}
