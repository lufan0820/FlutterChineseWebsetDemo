import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2019-12-30 15:45
/// 手势识别
/// TODO GestureDetector
/// GestureDetector是一个用于手势识别的功能性组件，我们通过它可以来识别各种手势。
/// GestureDetector实际上是指针事件的语义化封装
/// TODO 注意:
/// 当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，
/// 这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。
/// 如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。
///
/// TODO 拖动、滑动
/// onPanDown: (DragDownDetails e) DragDownDetails.globalPosition：
/// 当用户按下时，此属性为用户按下的位置相对于屏幕（而非父组件）原点(左上角)的偏移
/// onPanUpdate: (DragUpdateDetails e) DragUpdateDetails.delta：
/// 当用户在屏幕上滑动时，会触发多次Update事件，delta指一次Update事件的滑动的偏移量。
/// onPanEnd: (DragEndDetails e) DragEndDetails.velocity：
/// 该属性代表用户抬起手指时的滑动速度(包含x、y两个轴的），示例中并没有处理手指抬起时的速度，常见的效果是根据用户抬起手指时的速度做一个减速动画。
///
/// TODO 缩放
/// onScaleUpdate: (ScaleUpdateDetails e)  ScaleUpdateDetails.scale.clamp(最小倍数, 最大倍数)
/// 在图片上双指张开、收缩就可以放大、缩小图片
///
/// TODO GestureRecognizer
/// GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
/// 而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
/// GestureDetector直接可以接收一个子widget。GestureRecognizer是一个抽象类，
/// 一种手势的识别器对应一个GestureRecognizer的子类，Flutter实现了丰富的手势识别器，我们可以直接使用。
/// TODO 注意: 使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）
///
/// TODO 手势竞争
/// 如果在上例中我们同时监听水平和垂直方向的拖动事件，那么我们斜着拖动时哪个方向会生效？
/// 实际上取决于第一次移动时两个轴上的位移分量，哪个轴的大，哪个轴在本次滑动事件竞争中就胜出
/// 首次移动时的位移在水平和垂直方向上的分量大的一个获胜
///
/// TODO 手势冲突
/// 由于手势竞争最终只有一个胜出者，所以，当有多个手势识别器时，可能会产生冲突
/// 手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，
/// TODO 所以在遇到复杂的冲突场景时，都可以通过Listener直接识别原始指针事件来解决冲突

class TestGestureRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestGestureRouteState();
}

class _TestGestureRouteState extends State<TestGestureRoute> {
  // 保存事件名
  String _operation = "No Gesture detected";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("手势识别")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200,
              height: 100,
              child: Text(
                _operation,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => update("Tap"), // 点击
            onDoubleTap: () => update("DoubleTap"), // 双击
            onLongPress: () => update("LongPress"), // 长按
          ),
          _ScaleTestRoute(),
          _GestureRecognizerTestRoute(),
          Expanded(child: _GestureConflictTestRoute()),
          Expanded(child: _Drag()),
        ],
      ),
    );
  }

  void update(String text) {
    // 更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

// TODO 拖动/滑动
class _Drag extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  // 距离顶部的偏移
  double _top = 20.0;

  // 距离左边的偏移
  double _left = 20.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            // 手指按下时会触发次回调
            onPanDown: (DragDownDetails e) {
              // 打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            // 手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              // 用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              // 打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },

            /**
                // 单方向-垂直方向拖动事件
                onVerticalDragUpdate: (DragUpdateDetails e) {
                setState(() {
                _top += e.delta.dy;
                });
                },
             **/
            /**
                // 同时识别水平和垂直方向的拖动手势
                // 当用户按下手指时就会触发竞争(水平方向和垂直方向)
                // 一旦某个方向"获胜"，则直到当次拖动手势结束都会沿着该方向移动
                onVerticalDragUpdate: (DragUpdateDetails e) {
                setState(() {
                _top += e.delta.dy;
                });
                },
                onHorizontalDragUpdate: (DragUpdateDetails e) {
                setState(() {
                _left += e.delta.dx;
                });
                },
             **/
          ),
        ),
      ],
    );
  }
}

// TODO 缩放
class _ScaleTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<_ScaleTestRoute> {
  // 通过修改图片宽度来达到缩放效果
  double _width = 100.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: GestureDetector(
          // 指定宽度，高度自适应
          child: Image.asset(
            "images/sia_girl.png",
            width: _width,
          ),
          onScaleUpdate: (ScaleUpdateDetails e) {
            setState(() {
              // 缩放倍数在0.5到2倍之间
              _width = 100 * e.scale.clamp(.5, 2.0);
            });
          },
        ),
      ),
    );
  }
}

class _GestureRecognizerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureRecognizerTestRouteState();
}

class _GestureRecognizerTestRouteState
    extends State<_GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; // 变色开关

  @override
  void dispose() {
    // 用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "你好世界"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                fontSize: 30.0,
                color: _toggle ? Colors.blue : Colors.red,
              ),
              recognizer: _tapGestureRecognizer
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            ),
            TextSpan(text: "你好世界"),
          ],
        ),
      ),
    );
  }
}

class _GestureConflictTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState extends State<_GestureConflictTestRoute> {
  double _left = 20.0;

  // 当手指滑动结束时，滑动结束(onHorizontalDragEnd)和抬起(onTapUp) 会发生冲突
  // TODO 以下这种冲突场景，比如发生在轮播图中，需要在按下时停止轮播，抬起时恢复轮播，但是本身轮播图已经处理了拖动手势(手动滑动)，这个时候就需要Listener来监听原始指针事件，来解决这个冲突问题
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: _left,
          child: Listener(
            onPointerDown: (details) => print("onPointerDown"),
            onPointerUp: (details) => print("onPointerUp"),
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              // 要拖动和点击的widget
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) => print("onHorizontalDragEnd"),
            ),
          ),
        ),
      ],
    );
  }
}
