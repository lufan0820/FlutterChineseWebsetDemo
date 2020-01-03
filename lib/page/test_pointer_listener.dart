import 'package:flutter/material.dart';

/// * Create by lf 2019-12-30 10:14
/// 原始指针事件处理
///
/// TODO Listener
/// 在移动端，各个平台或UI系统的原始指针事件模型基本都是一致，即：
/// 一次完整的事件分为三个阶段：手指按下、手指移动、和手指抬起，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。
/// 当指针按下时，Flutter会对应用程序执行命中测试(Hit Test)，以确定指针与屏幕接触的位置存在哪些组件（widget），
/// 指针按下事件（以及该指针的后续事件）然后被分发到由命中测试发现的最内部的组件，然后从那里开始，事件会在组件树中向上冒泡，
/// 这些事件会从最内部的组件被分发到组件树根的路径上的所有组件，这和Web开发中浏览器的事件冒泡机制相似，
/// 但是Flutter中没有机制取消或停止“冒泡”过程，而浏览器的冒泡是可以停止的。注意，只有通过命中测试的组件才能触发事件。
///
/// 手指在蓝色矩形区域内移动即可看到当前指针偏移，当触发指针事件时，
/// 参数PointerDownEvent、PointerMoveEvent、PointerUpEvent都是PointerEvent的一个子类，
/// PointerEvent类中包括当前指针的一些信息，如：
/// position：它是鼠标相对于当对于全局坐标的偏移。
/// delta：两次指针移动事件（PointerMoveEvent）的距离。
/// pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
/// orientation：指针移动方向，是一个角度值。
/// 上面只是PointerEvent一些常用属性，除了这些它还有很多属性，读者可以查看API文档
///
/// TODO behavior
/// deferToChild：子组件会一个接一个的进行命中测试，
/// 如果子组件中有测试通过的，则当前组件通过，这就意味着，
/// 如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件
///
/// opaque：在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，
/// 最终的效果相当于当前Widget的整个区域都是点击区域
///
/// translucent：当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试，
/// 这意味着点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件

class TestPointerListenerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPointerListenerRouteState();
}

class _TestPointerListenerRouteState extends State<TestPointerListenerRoute> {
  // 定义一个状态保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("原始指针事件处理")),
      body: Center(
        child: Column(
          children: <Widget>[
            Listener(
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                color: Colors.blue,
                width: 320,
                height: 200,
                child: Text(_event?.toString() ?? "",
                    style: TextStyle(color: Colors.white)),
              ),
              onPointerDown: (PointerDownEvent event) =>
                  setState(() => _event = event),
              onPointerMove: (PointerMoveEvent event) =>
                  setState(() => _event = event),
              onPointerUp: (PointerUpEvent event) =>
                  setState(() => _event = event),
            ),
            // 只有点击文本时，才会触发事件
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300, 120)),
                child: Center(
                  child: Text("Box A"),
                ),
              ),
              behavior: HitTestBehavior.deferToChild,
              onPointerDown: (event) => print("down A"),
            ),
            // 点击文本或父布局都会触发事件
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300, 120)),
                child: Center(
                  child: Text("Box B"),
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onPointerDown: (event) => print("down B"),
            ),
            Stack(
              children: <Widget>[
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(300, 120)),
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blue)),
                  ),
                  onPointerDown: (event) => print("down0"),
                ),
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(200, 100)),
                    child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                  ),
                  onPointerDown: (event) => print("down1"),
                  // 放开此行注释后，点击顶部透明部分，可以触发down0('点透')
                  // 如果behavior值改为opaque，则只会触发down1
                  // behavior: HitTestBehavior.translucent,
                ),
              ],
            ),
            // 忽略PointerEvent
            // AbsorbPointer本身可以接受事件
            // IgnorePointer不会接受事件
            // 如果将下面的换成IgnorePointer,则2个都不会输出
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200,
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "忽略事件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPointerDown: (event) => print("in"),
                ),
              ),
              onPointerDown: (event) => print("up"),
            )
          ],
        ),
      ),
    );
  }
}
