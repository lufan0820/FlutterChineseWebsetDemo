import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2019-12-24 14:19
/// 可滚动组件
///
/// TODO ListView
/// ListView各个构造函数的公共参数
///
/// TODO itemExtent
/// 该参数如果不为null，则会强制children的“长度”为itemExtent的值；
/// 这里的“长度”是指滚动方向上子组件的长度，
/// 也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；
/// 如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。
/// 在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，
/// 这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，
/// 尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）
///
/// TODO shrinkWrap
/// 该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。
/// 默认情况下，ListView的会在滚动方向尽可能多的占用空间。
/// 当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true
///
/// TODO addAutomaticKeepAlives
/// 默认为true
/// 该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
/// 典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，
/// 在该列表项滑出视口时它也不会被GC（垃圾回收），它会使用KeepAliveNotification来保存其状态。
/// 如果列表项自己维护其KeepAlive状态，那么此参数必须置为false
///
/// TODO addRepaintBoundaries
/// 默认为true
/// 该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。
/// 当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，
/// 但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。
/// 和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false
///
/// TODO 注意：上面这些参数并非ListView特有，在本章后面介绍的其它可滚动组件也可能会拥有这些参数，它们的含义是相同的
///
/// TODO ListView.builder
/// 适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，
/// 也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的
/// TODO itemBuilder
/// 它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。
/// 当列表滚动到具体的index位置时，会调用该构建器构建列表项
/// TODO itemCount
/// 列表项的数量，如果为null，则为无限列表
///
/// TODO ListView.separated
/// 可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器
///
/// TODO ListView.custom
/// 自定义列表生成模型，需要实现一个SliverChildDelegate 用来给ListView生成列表项组件，详情参考API文档

class TestListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 定义下划线
    Widget blueDivider = Divider(color: Colors.blue);
    Widget greenDivider = Divider(color: Colors.green);

    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Column(
        children: <Widget>[
          // 这样创建出来的ListView,本质上和SingleChildScrollView+Column没有什么区别
          // 因为子组件已经提前创建好了，没有应用基于Sliver的懒应用模型
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return InfiniteListView();
                  }));
                },
                child: Text("无限加载列表"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HeaderListView();
                  }));
                },
                child: Text("带头的无限加载ListView"),
              ),
              const Text('I\'m dedicating every day to you'),
              const Text('Domestic life was never quite my style'),
              const Text('When you smile, you knock me out, I fall apart'),
              const Text('And I thought I was so smart'),
            ].map((e) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: e,
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemExtent: 50, // 强制高度50
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              // 列表构造器
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
              // 分割构造器
              separatorBuilder: (BuildContext context, int index) {
                return index % 2 == 0 ? blueDivider : greenDivider;
              },
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

// 实现无限加载列表
class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; // 表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
//    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("无限加载列表"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          // 如果到了表尾
          if (_words[index] == loadingTag) {
            // 不足100条，继续获取数据
            if (_words.length - 1 < 100) {
              // 获取数据
              _retrieveData();
              // 加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            } else {
              // 已经加载了100条，不在获取数据
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Text("没有更多了", style: TextStyle(color: Colors.grey)),
              );
            }
          }
          // 显示单词列表项
          return ListTile(title: Text(_words[index]));
        },
        separatorBuilder: (context, index) => Divider(height: .0),
        itemCount: _words.length,
      ),
    );
  }

  // 模拟从服务器获取数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
        _words.length - 1,
        // 每次生成20个单词
        generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
      );
      setState(() {
        // 重新构建列表
      });
    });
  }
}

// TODO Material设计规范中状态栏、导航栏、ListTile高度分别为24、56、56(不同的手机上可能会有细微误差)
class HeaderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("带头的无限加载ListView"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(title: Text("我是商品列表头")),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(title: Text("$index"));
            }),
          )
        ],
      ),
    );
  }
}
