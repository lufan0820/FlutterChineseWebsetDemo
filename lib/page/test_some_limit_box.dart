import 'package:flutter/material.dart';

/// * Create by lf 2019-12-22 16:37
/// 尺寸限制类容器
/// TODO ConstrainedBox
/// ConstrainedBox 用于对子组件添加额外的约束
/// BoxConstraints
/// 用于设置限制条件
/// 可以限制最大/最小的宽度/高度
/// 定义了一些便捷的构造函数，用于快速生成特定限制规则的BoxConstraints，
/// 如BoxConstraints.tight(Size size)，它可以生成给定大小的限制；
/// BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints
/// 详情查看API文档: https://docs.flutter.io/flutter/rendering/BoxConstraints-class.html
///
/// TODO SizedBox
/// 用于给子元素指定固定的宽度和高度
/// SizedBox 只是ConstrainedBox 一个定制,见下面的例子
///
/// TODO UnconstrainedBox
/// UnconstrainedBox不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制
///
/// TODO AspectRatio
/// 指定子组件的长宽比
///
/// TODO LimitedBox
/// 指定最大宽度
///
/// TODO FractionallySizedBox
/// 可以根据父容器宽高的百分比来设置子组件宽高等
///
/// 具体详见API文档

class TestSomeLimitBoxRoute extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("尺寸限制类容器"),
        actions: <Widget>[
          // loading按钮大小并没有发生变化，因为AppBar中已经指定了actions按钮的限制条件
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Colors.white70),
            ),
          ),
          Container(margin: EdgeInsets.only(left: 10)),
          // 使用UnconstrainedBox去除actions按钮的限制条件
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
          Container(margin: EdgeInsets.only(right: 10)),
        ],
      ),
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity, // 宽度尽可能大
              minHeight: 50.0, // 子widget的最小高度为50
            ),
            child: Container(
              height: 5.0,
              child: redBox,
            ),
          ),
          Container(margin: EdgeInsets.only(top: 10)),
          // SizedBox
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: redBox,
          ),
          Container(margin: EdgeInsets.only(top: 10)),
          // 上面的效果也可以用下面的方式实现
          // BoxConstraints.tightFor(width: 80.0,height: 80.0)
          // 等价于
          // BoxConstraints(minHeight:80.0,maxHeight:80.0,minWidth:80.0,maxWidth:80.0)
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: 80.0,
              height: 80.0,
            ),
            child: redBox,
          ),
          Container(margin: EdgeInsets.only(top: 10)),
          // 多重限制
          // 最终效果是minWidth = 90.0,minHeight = 60.0
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
              child: redBox,
            ),
          ),
          Container(margin: EdgeInsets.only(top: 10)),
          // 最终效果是minWidth = 90.0,minHeight = 60.0
          // TODO 通过2个例子，由此我们可以得出，多重限制，对于minWidth和minHeight来说，是取父子中相应数值较大的。
          // 通过这样才能保证父限制与子限制不冲突
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 子
              child: redBox,
            ),
          ),
          // UnconstrainedBox对父组件限制的“去除”并非是真正的去除
          // 去除的部分任然占有相应的空间
          // 父ConstrainedBox是作用于子UnconstrainedBox上，而redBox只受子ConstrainedBox限制
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 父
            // 去除父级限制
            child: UnconstrainedBox(
              // 子
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                child: redBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
