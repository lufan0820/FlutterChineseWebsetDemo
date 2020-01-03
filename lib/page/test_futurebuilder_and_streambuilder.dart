import 'package:flutter/material.dart';

/// * Create by lf 2019-12-26 15:30
/// 异步UI更新
/// TODO FutureBuilder
/// FutureBuilder会依赖一个Future，它会根据所依赖的Future的状态来动态构建自身
/// future：FutureBuilder依赖的Future，通常是一个异步耗时任务。
/// initialData：初始数据，用户设置默认数据。
/// builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用
///
/// TODO StreamBuilder
/// 我们知道，在Dart中Stream 也是用于接收异步事件数据，
/// 和Future 不同的是，它可以接收多个异步操作的结果，
/// 它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
/// StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件
/// 和FutureBuilder的构造函数只有一点不同：前者需要一个future，而后者需要一个stream。
/// TODO 在实战中，凡是UI会依赖多个异步数据而发生变化的场景都可以使用StreamBuilder。

class TestFutureBuilderAndStreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FutureBuilder&StreamBuilder")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              future: mockNetworkData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return Text("Contents: ${snapshot.data}");
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),
            Container(margin: EdgeInsets.only(top: 30)),
            StreamBuilder<int>(
              stream: counter(),
              // initialData: , // 一个Stream<int> 或者 null
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasError) Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("没有Stream");
                  case ConnectionState.waiting:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("等待数据..."),
                        CircularProgressIndicator()
                      ],
                    );
                  case ConnectionState.active:
                    return Text("active: ${snapshot.data}");
                  case ConnectionState.done:
                    return Text("Stream已关闭");
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }
}

// 模拟从服务器获取数据
Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从服务器获取的数据");
}

// 计数器，每隔1秒，计数加1
Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}
