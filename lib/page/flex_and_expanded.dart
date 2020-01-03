import 'package:flutter/material.dart';

/// * Create by lf 2019-12-20 15:05
///  弹性布局
/// TODO Flex
/// 沿着水平或垂直方向排列子组件
/// Row和Column都继承自Flex，参数基本相同，所以能使用Flex的地方基本上都可以使用Row或Column
/// Flex本身功能是很强大的，它也可以和Expanded组件配合实现弹性布局
///
/// TODO Expanded
/// 可以按比例“扩伸” Row、Column和Flex子组件所占用的空间

class FlexAndExpandedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹性布局"),
      ),
      body: Column(
        children: <Widget>[
          // Flex的两个子Widget按1:2来占据水平空间
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 30.0,
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 30.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              color: Colors.yellow,
              child: SizedBox(
                height: 100.0,
                // Flex的三个子Widget，在垂直方向按3:1:1来占用100像素的空间
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 30.0,
                        color: Colors.red,
                      ),
                    ),
                    Spacer(flex: 1), // TODO Spacer占用指定比例的空间 Expanded的一个包装类 详见源码
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
