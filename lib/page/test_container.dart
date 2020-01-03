import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2019-12-23 16:20
/// TODO Container
///
/// Container是一个组合类容器，它本身不对应具体的RenderObject，
/// 它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器，
/// 所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景
///
/// 有2点需要说明:
/// 1.容器的大小可以通过width、height属性来指定，
/// 也可以通过constraints来指定；如果它们同时存在时，width、height优先。
/// 实际上Container内部会根据width、height来生成一个constraints。
/// 2.color和decoration是互斥的，如果同时设置它们则会报错！
/// 实际上，当指定color时，Container内会自动创建一个decoration

class TestContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Container"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              // 容器外填充
              margin: EdgeInsets.only(top: 50.0, left: 120.0, bottom: 50),
              // 卡片大小
              constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
              // 背景装饰
              decoration: BoxDecoration(
                // 背景径向渐变
                gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: .98),
                // 卡片阴影
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  ),
                ],
                // 圆角
                borderRadius: BorderRadius.circular(4.0),
              ),
              // 卡片倾斜发生变化
              transform: Matrix4.rotationZ(.2),
              // 卡片内文字居中
              alignment: Alignment.center,
              // 卡片文字
              child: Text(
                "5.20",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            // Container padding 和 margin 区别
            Container(
              margin: EdgeInsets.all(20.0),
              color: Colors.orange,
              child: Text("Hello World"),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.orange,
              child: Text("Hello World"),
            ),
            // Container内的margin和padding都是通过Padding组件来实现的，上面的等价于下面的
            Padding(
              padding: EdgeInsets.all(20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text("Hello World"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.orange),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Hello World"),
              ),
            )
          ],
        ));
  }
}
