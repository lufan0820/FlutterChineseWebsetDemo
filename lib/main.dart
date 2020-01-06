import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'page/common_widget.dart';
import 'page/context_route.dart';
import 'page/cupertino_test_route.dart';
import 'page/event/test_event_login.dart';
import 'page/event/test_event_page.dart';
import 'page/flex_and_expanded.dart';
import 'page/image_and_icon.dart';
import 'page/lifecycle_state.dart';
import 'page/manage_state/f_manage_s_state.dart';
import 'page/manage_state/manage_itself_state.dart';
import 'page/manage_state/mixing_manage_state.dart';
import 'page/random_words.dart';
import 'page/route_name_dispatch_param.dart';
import 'page/some_button.dart';
import 'page/stack_and_positioned.dart';
import 'page/switch_and_checkbox.dart';
import 'page/test_align.dart';
import 'page/test_animation/test_animated_switcher.dart';
import 'page/test_animation/test_basic_version_animation.dart';
import 'page/test_animation/test_hero_animation.dart';
import 'page/test_animation/test_interweave_animation.dart';
import 'page/test_animation/test_page_route_animaiton.dart';
import 'page/test_clip.dart';
import 'page/test_color_and_theme.dart';
import 'page/test_container.dart';
import 'page/test_custom_scrollview.dart';
import 'page/test_decoration_box.dart';
import 'page/test_dialog.dart';
import 'page/test_form.dart';
import 'page/test_futurebuilder_and_streambuilder.dart';
import 'page/test_gesture.dart';
import 'page/test_gridview.dart';
import 'page/test_inherited_widget.dart';
import 'page/test_listview.dart';
import 'page/test_new_route.dart';
import 'page/test_new_route_with_param.dart';
import 'page/test_notification.dart';
import 'page/test_padding.dart';
import 'page/test_pointer_listener.dart';
import 'page/test_progress_indicator.dart';
import 'page/test_provider/test_provider.dart';
import 'page/test_row_and_column.dart';
import 'page/test_scaffold.dart';
import 'page/test_scroll_controller.dart';
import 'page/test_single_child_scrollview.dart';
import 'page/test_some_limit_box.dart';
import 'page/test_textfield.dart';
import 'page/test_transform.dart';
import 'page/text_and_style.dart';
import 'page/widget_tree_context_get_state.dart';
import 'page/wrap_and_flow.dart';
import 'utils/cupertino_localizations_zh.dart';
import 'utils/toast_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "home",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        ChineseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: Locale('zh'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 注册路由表
      routes: {
        "home": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "new_route": (context) => NewRoute(),
        "router_test_route": (context) => RouterTestRoute(),
        "tip_route": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
        "new_page_dispatch_param": (context) => EchoRoute(),
        "context_route": (context) => ContextRoute(),
        "lifecycle_route": (context) => CounterWidget(initValue: 1),
        "context_get_state": (context) => TestWidgetContextGetState(),
        "cupertino_test_route": (context) => CupertinoTestRoute(),
        "manage_self_state_tab": (context) => ManageSelfStateTab(),
        "f_manage_s_state_tab": (context) => ParentWidget(),
        "mixing_manage_state_tab": (context) => ParentWidgetC(),
        "text_and_style": (context) => TextAndStyle(),
        "some_button": (context) => SomeButton(),
        "image_and_icon": (context) => ImageAndIcon(),
        "switch_and_checkbox": (context) => SwitchAndCheckBox(),
        "textfield_test_route": (context) => TextFieldTestRoute(),
        "form_test_route": (context) => FormTestRoute(),
        "progress_indicator_route": (context) => ProgressIndicatorRoute(),
        "row_and_column": (context) => TestRowAndColumnRoute(),
        "flex_and_expanded": (context) => FlexAndExpandedRoute(),
        "wrap_and_flow": (context) => WrapAndFlowRoute(),
        "stack_and_positioned": (context) => StackAndPositionedRoute(),
        "test_align_route": (context) => TestAlignRoute(),
        "test_padding_route": (context) => TestPaddingRoute(),
        "test_some_limit_box_route": (context) => TestSomeLimitBoxRoute(),
        "test_decoration_box_route": (context) => TestSomeDecorationBoxRoute(),
        "test_transform_route": (context) => TestTransformRoute(),
        "test_container_route": (context) => TestContainerRoute(),
        "test_scaffold_route": (context) => TestScaffoldRoute(),
        "test_scaffold_route": (context) => TestScaffoldRoute(),
        "test_clip_route": (context) => TestClipRoute(),
        "test_single_child_scrollview_route": (context) =>
            TestSingleChildScrollViewRoute(),
        "test_listview_route": (context) => TestListViewRoute(),
        "test_gridview_route": (context) => TestGridViewRoute(),
        "test_customscrollview_route": (context) => TestCustomScrollViewRoute(),
        "test_scroll_controller_route": (context) =>
            TestScrollControllerRoute(),
        "test_inheritedwidget_route": (context) => TestInheritedWidgetRoute(),
        "test_provider_route": (context) => TestProviderRoute(),
        "test_color_and_theme": (context) => TestColorAndThemeRoute(),
        "test_futurebuilder_and_streambuilder": (context) =>
            TestFutureBuilderAndStreamBuilderRoute(),
        "test_dialog_route": (context) => TestDialogRoute(),
        "test_pointer_listener_route": (context) => TestPointerListenerRoute(),
        "test_gesture_route": (context) => TestGestureRoute(),
        "test_event_page": (context) => TestEventPageRoute(),
        "test_event_login": (context) => TestEventLoginRoute(),
        "test_notification_route": (context) => TestNotificationRoute(),
        "test_basic_version_animation_route": (context) =>
            TestBasicVersionAnimationRoute(),
        "test_page_animation_route": (context) => TestPageAnimationRoute(),
        "test_hero_animation_route": (context) => TestHeroAnimationRoute(),
        "test_interweave_animation_route": (context) =>
            TestInterWeaveAnimationRoute(),
        "test_animated_switcher_route": (context) =>
            TestAnimatedSwitcherRoute(),
      },
      // 打开命名路由时，
      // 如果该路由在注册表中注册了，则打开该路由
      // 如果没有注册则调用onGenerateRoute回调
      // 所以要实现在打开路由前检查用户是否登录，则可以舍弃命名路由注册(路由表)
      // 改由onGenerateRoute回调中增加限制
      // onGenerateRoute只会对命名路由生效
//      onGenerateRoute: (RouteSettings settings) {
//        return MaterialPageRoute(builder: (context) {
//          // 如果访问的路由页需要登录，则检查登录状态
//          // 未登录，直接返回登录路由,引导登录操作
//          // 登录,正常打开路由
//          // String routeName = settings.name;
//        });
//      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _lastPressedAt; // 上次点击的时间

  int _counter = 0;

  final List<String> items = [
    "打开新的路由",
    "路由之间的参数相互传递",
    "通过pushNamed打开新路由并传递参数",
    "Context测试",
    "state生命周期",
    "在Widget树中获取State对象(Context)",
    "Cupertino风格组件",
    "管理自身的状态",
    "父管理子的状态",
    "混合管理状态",
    "文本及样式",
    "各种按钮",
    "图片以及Icon",
    "单选开关和复选框",
    "输入框",
    "表单",
    "进度指示器",
    "线性布局(Row/Column)",
    "弹性布局(Flex+Expanded)",
    "流式布局(Wrap/Flow)",
    "层叠布局(Stack+Positioned)",
    "对齐与相对定位(Align)",
    "填充(Padding)",
    "尺寸限制类容器",
    "装饰容器(DecoratedBox)",
    "变换(Transform)",
    "Conatiner",
    "Scaffold、TabBar、底部导航",
    "裁剪(Clip)",
    "可滚动组件(SingleChildScrollView)",
    "可滚动组件(ListView)",
    "可滚动组件(GridView)",
    "可滚动组件(CustomScrollView)",
    "滚动监听及控制(ScrollController)",
    "数据共享(InheritedWidget)",
    "跨组件数据共享(Provider)",
    "颜色和主题(Color&Theme)",
    "异步UI更新(FutureBuilder、StreamBuilder)",
    "对话框详解",
    "原始指针事件处理",
    "手势识别",
    "事件总线",
    "通知(Notification)",
    "动画基本结构",
    "自定义路由过渡动画",
    "Hero动画",
    "交织动画",
    "通用'切换动画'组件(AnimatedSwitcher)",
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  /// TODO 导航返回拦截（WillPopScope）
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 2)) {
            // 两次点击间隔超过2秒则重新计时
            _lastPressedAt = DateTime.now();
            showToast("再按一次退出App");
          } else {
            // 退出APP,并杀掉当前App的进程
            SystemNavigator.pop();
            exit(0);
          }
          return Future.value(false);
        },
        child: Column(
          children: <Widget>[
            RandomWordsWidget(),
            new Text("$_counter", style: Theme.of(context).textTheme.display1),
            EchoWidget(text: "Hello World", backgroundColor: Colors.blue),
            Expanded(
              child: ListView.separated(
                itemCount: items.length + 1,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: .5);
                },
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    onPressed: () => _onTap(context, index),
                    child: index >= items.length
                        ? Divider(color: Colors.transparent)
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${items[index]}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // 导航到新路由
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        // return NewRoute();
        // }));
        // 通过路由名称来打开新的路由
        Navigator.pushNamed(context, "new_route");
        break;
      case 1:
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        // return RouterTestRoute();
        // }));
        // Navigator.pushReplacementNamed( context, "router_test_route");
        Navigator.pushNamed(context, "router_test_route");
        // Navigator.of(context).pushNamed("tip_route", arguments: "我是参数....");
        break;
      case 2:
        Navigator.of(context)
            .pushNamed("new_page_dispatch_param", arguments: "hi i`m param");
        break;
      case 3:
        Navigator.pushNamed(context, "context_route");
        break;
      case 4:
        Navigator.pushNamed(context, "lifecycle_route");
        break;
      case 5:
        Navigator.pushNamed(context, "context_get_state");
        break;
      case 6:
        Navigator.pushNamed(context, "cupertino_test_route");
        break;
      case 7:
        Navigator.pushNamed(context, "manage_self_state_tab");
        break;
      case 8:
        Navigator.pushNamed(context, "f_manage_s_state_tab");
        break;
      case 9:
        Navigator.pushNamed(context, "mixing_manage_state_tab");
        break;
      case 10:
        Navigator.pushNamed(context, "text_and_style");
        break;
      case 11:
        Navigator.pushNamed(context, "some_button");
        break;
      case 12:
        Navigator.pushNamed(context, "image_and_icon");
        break;
      case 13:
        Navigator.pushNamed(context, "switch_and_checkbox");
        break;
      case 14:
        Navigator.pushNamed(context, "textfield_test_route");
        break;
      case 15:
        Navigator.pushNamed(context, "form_test_route");
        break;
      case 16:
        Navigator.pushNamed(context, "progress_indicator_route");
        break;
      case 17:
        Navigator.pushNamed(context, "row_and_column");
        break;
      case 18:
        Navigator.pushNamed(context, "flex_and_expanded");
        break;
      case 19:
        Navigator.pushNamed(context, "wrap_and_flow");
        break;
      case 20:
        Navigator.pushNamed(context, "stack_and_positioned");
        break;
      case 21:
        Navigator.pushNamed(context, "test_align_route");
        break;
      case 22:
        Navigator.pushNamed(context, "test_padding_route");
        break;
      case 23:
        Navigator.pushNamed(context, "test_some_limit_box_route");
        break;
      case 24:
        Navigator.pushNamed(context, "test_decoration_box_route");
        break;
      case 25:
        Navigator.pushNamed(context, "test_transform_route");
        break;
      case 26:
        Navigator.pushNamed(context, "test_container_route");
        break;
      case 27:
        Navigator.pushNamed(context, "test_scaffold_route");
        break;
      case 28:
        Navigator.pushNamed(context, "test_clip_route");
        break;
      case 29:
        Navigator.pushNamed(context, "test_single_child_scrollview_route");
        break;
      case 30:
        Navigator.pushNamed(context, "test_listview_route");
        break;
      case 31:
        Navigator.pushNamed(context, "test_gridview_route");
        break;
      case 32:
        Navigator.pushNamed(context, "test_customscrollview_route");
        break;
      case 33:
        Navigator.pushNamed(context, "test_scroll_controller_route");
        break;
      case 34:
        Navigator.pushNamed(context, "test_inheritedwidget_route");
        break;
      case 35:
        Navigator.pushNamed(context, "test_provider_route");
        break;
      case 36:
        Navigator.pushNamed(context, "test_color_and_theme");
        break;
      case 37:
        Navigator.pushNamed(context, "test_futurebuilder_and_streambuilder");
        break;
      case 38:
        Navigator.pushNamed(context, "test_dialog_route");
        break;
      case 39:
        Navigator.pushNamed(context, "test_pointer_listener_route");
        break;
      case 40:
        Navigator.pushNamed(context, "test_gesture_route");
        break;
      case 41:
        Navigator.pushNamed(context, "test_event_page");
        break;
      case 42:
        Navigator.pushNamed(context, "test_notification_route");
        break;
      case 43:
        Navigator.pushNamed(context, "test_basic_version_animation_route");
        break;
      case 44:
        Navigator.pushNamed(context, "test_page_animation_route");
        break;
      case 45:
        Navigator.pushNamed(context, "test_hero_animation_route");
        break;
      case 46:
        Navigator.pushNamed(context, "test_interweave_animation_route");
        break;
      case 47:
        Navigator.pushNamed(context, "test_animated_switcher_route");
        break;
    }
  }
}
