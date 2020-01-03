import 'package:flutter/material.dart';

/// * Create by lf 2020-01-02 15:27
/// TODO Notification
/// 通知是Flutter中一个重要的机制，在widget树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递
/// 所有父节点都可以通过NotificationListener来监听通知
/// Flutter中将这种由子向父的传递通知的机制称为通知冒泡。
/// 通知冒泡和用户事件冒泡是相似的，但有一点不同： 通知冒泡可以终止，但用户触摸事件不行。
///
/// Flutter的UI框架实现中，除了在可滚动组件在滚动过程中会发出ScrollNotification之外，
/// 还有一些其它的通知，如:
/// TODO SizeChangedLayoutNotification、KeepAliveNotification、LayoutChangedNotification等
/// Flutter正是通过这种通知机制来使父元素可以在一些特定时机来做一些事件。
///
/// TODO 自定义通知
/// Notification有一个dispatch(context)方法，它是用于分发通知的

class TestNotificationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NotificationListener")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: NotificationListener(
              onNotification: (notification) {
                switch (notification.runtimeType) {
                  case ScrollStartNotification:
                    print("开始滚动");
                    break;
                  case ScrollUpdateNotification:
                    print("正在滚动");
                    break;
                  case ScrollEndNotification:
                    print("滚动停止");
                    break;
                  case OverscrollNotification:
                    print("滚动到边界");
                    break;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                },
              ),
            ),
          ),
          SizedBox(
            height: 200,
            // NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自Notification；
            // 当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知
            // 指定监听通知的类型为滚动结束通知(ScrollEndNotification)
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                // 只会在滚动结束时才会触发此回调
                print(notification);
                // 接受bool值
                // 返回true时，阻止冒泡，其父级Widget将再也收不到回调通知；
                // 返回false时，继续向上冒泡通知。
                return false;
              },
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _NotificationRoute(),
          )
        ],
      ),
    );
  }
}

// 自定义通知
class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

class _NotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<_NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    // 监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        // 打印通知
        print(notification);
        return false;
      },
      child: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg;
          });
          // 如果子NotificationListener这里返回true，则上面的父NotificationListener就不会打印通知了，
          // 因为子NotificationListener阻止事件继续向父传递，即终止通知冒泡了
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 注意注释部分是错误的写法，因为这个context是根context，
              // 而NotificationListener是监听的子树，所以需要通过Builder来构建RaisedButton
              /**
                  RaisedButton(
                  // 点击按钮时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                  )
               **/
              Builder(
                builder: (context) {
                  return RaisedButton(
                    // 点击按钮时分发通知
                    onPressed: () => MyNotification("Hi").dispatch(context),
                    child: Text("Send Notification"),
                  );
                },
              ),
              Text(_msg),
            ],
          ),
        ),
      ),
    );
  }
}
