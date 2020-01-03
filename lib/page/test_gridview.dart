import 'package:flutter/material.dart';

/// * Create by lf 2019-12-24 15:41
///
/// 可滚动组件
/// TODO GridView
/// GridView和ListView的大多数参数都是相同的，它们的含义也都相同的
///
/// TODO gridDelegate
/// 类型是SliverGridDelegate,它的作用是控制GridView子组件如何排列
///
/// SliverGridDelegate的子类
/// TODO SliverGridDelegateWithFixedCrossAxisCount
/// 该子类实现了一个横轴为固定数量子元素的layout算法
///  TODO crossAxisCount
///  横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
///  TODO mainAxisSpacing
///  主轴方向的间距
///  TODO crossAxisSpacing
///  横轴方向子元素的间距
///  TODO childAspectRatio
///  子元素在横轴长度和主轴长度的比例。
///  由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度
///
///
/// TODO SliverGridDelegateWithMaxCrossAxisExtent
/// 该子类实现了一个横轴子元素为固定最大长度的layout算法
///  TODO maxCrossAxisExtent
///  为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的，
///  举个例子，如果ViewPort的横轴长度是450，那么当maxCrossAxisExtent的值在区间[450/4，450/3)内的话，
///  子元素最终实际长度都为112.5，而childAspectRatio所指的子元素横轴和主轴的长度比为最终的长度比。
///  其它参数和SliverGridDelegateWithFixedCrossAxisCount相同
///
/// TODO flutter_staggered_grid_view 第三库 实现了类似于流式布局的布局模型

class TestGridViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return InfiniteGridView();
            })),
            child: Text("从异步数据源获取数据"),
          ),
          SizedBox(
            height: 300,
            // 纵轴固定数量的GridView
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 横轴3个子组件
                childAspectRatio: 1.0, // 宽高比为1
              ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          // 上面的代码等价于下面的代码
          /** SizedBox(
              height: 120,
              child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1,
              children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast),
              ],
              ),
              ), **/
          SizedBox(
            height: 200,
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100.0,
                childAspectRatio: 2.0, // 宽高比为2
              ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          // 上面的代码等价下面的代码
          /** SizedBox(
              height: 100,
              child: GridView.extent(
              maxCrossAxisExtent: 100.0,
              childAspectRatio: 2.0,
              children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast),
              ],
              ),
              ), **/
        ],
      ),
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = []; // 保存Icon数据

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView从异步加载数据"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行三列
          childAspectRatio: 1.0, // 显示区域宽高相等
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          // 如果显示到最后一个并且Icon总数小于100时，继续获取数据
          if (index == _icons.length - 1 && _icons.length < 100) {
            _retrieveData();
          }
          return Icon(_icons[index]);
        },
      ),
    );
  }

  // 模拟异步获取数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 1)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
