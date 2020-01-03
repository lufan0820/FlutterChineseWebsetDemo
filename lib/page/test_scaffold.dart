import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

/// * Create by lf 2019-12-23 16:54
/// Scaffold、TabBar、底部导航
/// 其他组件可以查看相关文档
///

// 实现如下一个页面
// 一个导航栏
// 导航栏右边有一个分享按钮
// 有一个抽屉菜单
// 右下角有一个悬浮的动作按钮
// 顶部Tab菜单
class TestScaffoldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestScaffoldRouteState();
}

class _TestScaffoldRouteState extends State<TestScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _selectIndex = 0;

  TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    // 创建TabController
    _tabController = TabController(length: tabs.length, vsync: this);

    // Tab页和Tab菜单需要同步，所以通过事情来监听
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Name"),
          centerTitle: true,
          // 修改右侧导航栏默认图标
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: () {
                // 打开抽屉
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          // 导航栏右侧菜单
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.share))
          ],
          // tab菜单
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        // 抽屉
        drawer: MyDrawer(),
        /**
         * BottomNavigationBar(
            // 底部导航栏
            items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text("Business"),
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("School"),
            ),
            ],
            currentIndex: _selectIndex,
            fixedColor: Colors.blue,
            onTap: _onItemTapped,
            )
         */
        // 底部导航栏
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: _selectIndex == 0 ? Colors.blue : Colors.black,
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.business),
                color: _selectIndex == 1 ? Colors.blue : Colors.black,
                onPressed: () => _onItemTapped(1),
              ),
              SizedBox(width: 60), // 中间空出位置
              IconButton(
                icon: Icon(Icons.school),
                color: _selectIndex == 2 ? Colors.blue : Colors.black,
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                color: _selectIndex == 3 ? Colors.blue : Colors.black,
                onPressed: () => _onItemTapped(3),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showToast("底部悬浮按钮");
          },
          splashColor: Colors.white,
          tooltip: "tooltip",
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // TabBarView组件，通过它不仅可以轻松的实现Tab页，而且可以非常容易的配合TabBar来实现同步切换和滑动状态同步
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            //创建3个Tab页
            return Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 5),
            );
          }).toList(),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // MediaQuery.removePadding移除Drawer默认的一些留白(比如Drawer默认顶部会留和手机状态栏等高的留白)
      child: MediaQuery.removePadding(
        context: context,
        // 移除抽屉菜单，顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipOval(
                      child: Image.asset(
                        "images/1.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "LF",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: Text("Add count"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text("Manage accounts"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
