import 'package:flutter/material.dart';

/// * Create by lf 2019-12-25 15:19
/// 数据共享
/// TODO InheritedWidget
/// InheritedWidget是Flutter中非常重要的一个功能组件，它提供了一种数据在widget树中从上到下传递、共享的方式，
/// 比如我们在应用的根widget中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget中来获取该共享的数据！
/// 这个特性在一些需要在widget树中共享数据的场景中非常方便！
/// 如Flutter SDK中正是通过InheritedWidget来共享应用主题(Theme)和Local(当前语言环境)信息的。
///
/// TODO didChangeDependencies
/// 在之前介绍StatefulWidget时，我们提到State对象有一个didChangeDependencies回调，它会在“依赖”发生变化时被Flutter Framework调用。
/// 而这个“依赖”指的就是子widget是否使用了父widget中InheritedWidget的数据！
/// 如果使用了，则代表子widget依赖有依赖InheritedWidget；如果没有使用则代表没有依赖。
/// 这种机制可以使子组件在所依赖的InheritedWidget变化时来更新自身！
/// 比如当主题、locale(语言)等发生变化时，依赖其的子widget的didChangeDependencies方法将会被调用

/// TODO 本例子主要为了演示InheritedWidget的功能特性,不是计数器的推荐实现方式
class TestInheritedWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestInheritedWidgetRouteState();
}

class _TestInheritedWidgetRouteState extends State<TestInheritedWidgetRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("数据共享(InheritedWidget)")),
      body: Center(
        child: ShareDataWidget(
          data: _count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: _TestWidget(),
              ),
              RaisedButton(
                // 每点击一次，将_count自增，然后重新build，ShareDataWidget的data将被更新
                onPressed: () => setState(() => ++_count),
                child: Text("Increment"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

/// TODO 如果_TestWidget build方法中没有依赖ShareDataWidget,那么didChangeDependencies是不会被调用的
class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      ShareDataWidget.of(context).data.toString(),
      style: TextStyle(color: Colors.black54),
    );
//    return Text("text");
  }

  // 如果需要在依赖改变后执行一些昂贵的操作，比如网络请求，那么最后就是该回调中来执行了。
  // 由此可以避免在build中执行这些昂贵的操作
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    // 如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("didChangeDependencies被调用了!");
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data; // 需要在子树中共享的数据，保存点击次数

  // 定义一个便捷的方法，方便子树中调用
  // TODO https://book.flutterchina.club/chapter7/inherited_widget.html
  static ShareDataWidget of(BuildContext context) {
    // 如果我希望ShareDataWidget数据发送变化时,_TestWidgetState中的didChangeDependencies不会被调用
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
        .widget;
//    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 该回调决定当data发生变化时，是否通知子树中的依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 如果返回true，则子树中依赖(build函数中有调用)本Widget的子Widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}
