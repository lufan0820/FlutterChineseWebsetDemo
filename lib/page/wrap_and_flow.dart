import 'package:flutter/material.dart';

/// * Create by lf 2019-12-20 15:23
/// 流式布局
/// TODO Wrap
/// Wrap的很多属性在Row（包括Flex和Column）中也有
/// 可以认为Wrap和Flex（包括Row和Column）除了超出显示范围后Wrap会折行外，其它行为基本相同
/// Wrap特有的几个属性：
/// spacing：主轴方向子widget的间距
/// runSpacing：纵轴方向的间距
/// runAlignment：纵轴方向的对齐方式
///
/// TODO Flow
/// 我们一般很少会使用Flow，因为其过于复杂，
/// 需要自己实现子widget的位置转换，在很多场景下首先要考虑的是Wrap是否满足需求。
/// Flow主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景。
/// Flow有如下优点：
///  1.性能好；Flow是一个对子组件尺寸以及位置调整非常高效的控件，
///   Flow用转换矩阵在对子组件进行位置调整的时候进行了优化：
///   在Flow定位过后，如果子组件的尺寸或者位置发生了变化，
///   在FlowDelegate中的paintChildren()方法中调用context.paintChild 进行重绘，
///   而context.paintChild在重绘时使用了转换矩阵，并没有实际调整组件位置。
///  2.灵活；由于我们需要自己实现FlowDelegate的paintChildren()方法，
///    所以我们需要自己计算每一个组件的位置，因此，可以自定义布局策略。
/// 缺点：
///  1.使用复杂。
///  2.不能自适应子组件大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。

class WrapAndFlowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("流式布局"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴(垂直)方向间距
              alignment: WrapAlignment.center, // 沿主轴方向居中
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("A"),
                  ),
                  label: Text("Hamilton"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("M"),
                  ),
                  label: Text("Lafayette"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("H"),
                  ),
                  label: Text("Mulligan"),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("J"),
                  ),
                  label: Text("Laurens"),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Text("Flow实现六个色块流式布局"),
                  Container(margin: EdgeInsets.only(top: 5)),
                  Flow(
                    delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
                    children: <Widget>[
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.red,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.green,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.orange,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.purple,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.brown,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Text("Wrap实现六个色块流式布局"),
                  Container(margin: EdgeInsets.only(top: 10)),
                  Wrap(
                    spacing: (MediaQuery.of(context).size.width - 80 * 3) / 4,
                    runSpacing:
                        (MediaQuery.of(context).size.width - 80 * 3) / 4,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.red,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.green,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.orange,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.purple,
                      ),
                      new Container(
                        width: 80,
                        height: 80,
                        color: Colors.brown,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  TestFlowDelegate({this.margin});

  EdgeInsets margin = EdgeInsets.zero;

  /// 它的主要任务是确定每个子widget位置
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每一个子Widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 绘制子Widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  /// 由于Flow不能自适应子widget的大小，我们通过在getSize返回一个固定大小来指定Flow的大小
  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小
    return Size(double.infinity, 200.0);
  }
}
