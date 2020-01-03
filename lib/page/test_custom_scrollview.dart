import 'package:flutter/material.dart';

/// * Create by lf 2019-12-24 16:38
/// 可滚动组件
/// TODO CustomScrollView
/// CustomScrollView是可以使用Sliver来自定义滚动模型（效果）的组件
/// 实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是
/// 前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，
/// 也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，
/// 这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果
///
/// TODO CustomScrollView的子组件必须都是Sliver

class TestCustomScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 因为本路由没有使用Scaffold，为了让子级Widget使用
    // Material Design 默认的样式风格，我们使用Material 作为本路由的根.
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          // AppBar包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("CustomScrollView"),
              background: Image.asset("images/sia_girl.png", fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
            ),
          ),
          // List
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // 创建列表项
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 10)],
                  child: Text("list item $index"),
                );
              },
              childCount: 50, // 50个列表项
            ),
            itemExtent: 50,
          )
        ],
      ),
    );
  }
}
