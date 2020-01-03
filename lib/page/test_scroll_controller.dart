import 'package:flutter/material.dart';

/// * Create by lf 2019-12-25 11:23
/// 滚动监听及控制
/// TODO ScrollController
///
/// initialScrollOffset 初始滚动位置
/// keepScrollOffset 是否保存滚动位置
///
/// TODO offset
/// 可滚动组件当前的滚动位置
///
/// TODO jumpTo(double offset)、animateTo(double offset,...)
/// 这两个方法用于跳转到指定的位置，它们不同之处在于，后者在跳转时会执行一个动画，而前者不会
///
/// TODO PageStorage
/// PageStorage是一个用于保存页面(路由)相关数据的组件，它并不会影响子树的UI外观，
/// 其实，PageStorage是一个功能型组件，它拥有一个存储桶（bucket），
/// 子树中的Widget可以通过指定不同的PageStorageKey来存储各自的数据或状态
/// 每次滚动结束，可滚动组件都会将滚动位置offset存储到PageStorage中，当可滚动组件重新创建时再恢复
///
/// TODO ScrollPosition
/// ScrollPosition是用来保存可滚动组件的滚动位置的
/// 一个ScrollController对象可以同时被多个可滚动组件使用，ScrollController会为每一个可滚动组件创建一个ScrollPosition对象，
/// 这些ScrollPosition保存在ScrollController的positions属性中（List<ScrollPosition>）。
/// ScrollPosition是真正保存滑动位置信息的对象，offset只是一个便捷属性
///
/// ScrollPosition有两个常用方法：animateTo() 和 jumpTo()，它们是真正来控制跳转滚动位置的方法，
/// ScrollController的这两个同名方法，内部最终都会调用ScrollPosition的
///
/// TODO NotificationListener
/// 滚动监听
/// 通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同
/// 1.通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。
/// 而ScrollController只能和具体的可滚动组件关联后才可以。
/// 2.收到滚动事件后获得的信息不同；
/// NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，
/// 而ScrollController只能获取当前滚动位置

class TestScrollControllerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestScrollControllerRouteState();
}

class _TestScrollControllerRouteState extends State<TestScrollControllerRoute> {
  ScrollController _scrollController = new ScrollController();
  bool showToTopButton = false; // 是否显示‘返回顶部’按钮

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，打印滚动的位置
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      print(offset);
      if (offset < 1000 && showToTopButton) {
        setState(() {
          showToTopButton = false;
        });
      } else if (offset >= 1000 && !showToTopButton) {
        setState(() {
          showToTopButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄漏 及时销毁controller
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollController"),
        actions: <Widget>[
          FlatButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return _TestScrollNotificationRoute();
            })),
            child: Text(
              "监听滚动通知",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50, // 列表项高度固定时，显示指定高度是一个好习惯(性能消耗小)
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ListTile(title: Text("$index"));
          },
        ),
      ),
      floatingActionButton: !showToTopButton
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                // 返回到顶部时执行动画
                _scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}

class _TestScrollNotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestScrollNotificationRouteState();
}

class _TestScrollNotificationRouteState
    extends State<_TestScrollNotificationRoute> {
  String _progress = "0"; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("监听滚动通知")),
      body: Scrollbar(
        // 进度条
        // 监听滚动通知
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            /// TODO ScrollMetrics
            /// pixels：当前滚动位置。
            /// maxScrollExtent：最大可滚动长度。
            /// extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
            /// extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
            /// extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
            /// atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）
            /// 其他属性详见API文档
            ScrollMetrics scrollMetrics = scrollNotification.metrics;
            double progress =
                scrollMetrics.pixels / scrollMetrics.maxScrollExtent;
            // 重新构建
            setState(() {
              _progress = "${(progress * 100).toInt()}";
            });
            print("BottomEdge : ${scrollMetrics.extentAfter == 0}");
            return false; //返回true，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemCount: 100,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                },
              ),
              CircleAvatar(
                // 显示进度百分比
                radius: 30,
                child:
                    Text("$_progress%", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
