import 'package:flutter/material.dart';

/// * Create by lf 2019-12-26 11:32
/// 颜色和主题
/// TODO Color
/// 将颜色字符串转成Color对象(详见: https://book.flutterchina.club/chapter7/theme.html)
///
/// 颜色亮度
/// Color类中提供了一个computeLuminance()方法，它可以返回一个[0-1]的一个值，数字越大颜色就越浅
///
/// TODO MaterialColor
/// MaterialColor是实现Material Design中的颜色的类，它包含一种颜色的10个级别的渐变色
/// MaterialColor通过"[]"运算符的索引值来代表颜色的深度，有效的索引有：50，100，200，…，900，数字越大，颜色越深。
/// MaterialColor的默认值为索引等于500的颜色
///
/// TODO Theme
/// Theme组件可以为Material APP定义主题数据（ThemeData）。
/// Material组件库里很多组件都使用了主题数据，如导航栏颜色、标题字体、Icon样式等。
/// Theme内会使用InheritedWidget来为其子树共享样式数据
///
/// TODO ThemeData
/// ThemeData用于保存是Material 组件库的主题数据，Material组件需要遵守相应的设计规范，
/// 而这些规范可自定义部分都定义在ThemeData中了，所以我们可以通过ThemeData来自定义应用主题。
/// 在子组件中，我们可以通过Theme.of方法来获取当前的ThemeData
/// 需要注意的是：Material Design 设计规范中有些是不能自定义的，如导航栏高度，ThemeData只包含了可自定义部分
/// ThemeData部分数据定义: https://book.flutterchina.club/chapter7/theme.html
///
/// 如果想实现全局的换Theme，则可以去修复MaterialApp的theme属性。

class TestColorAndThemeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestColorAndThemeRouteState();
}

class _TestColorAndThemeRouteState extends State<TestColorAndThemeRoute> {
  List<Color> blueColorsValue = [
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
  ];
  List<String> blueColorsStringValue = [
    "#FFE3F2FD",
    "#FFBBDEFB",
    "#FF90CAF9",
    "#FF64B5F6",
    "#FF42A5F5",
    "#FF2196F3",
    "#FF1E88E5",
    "#FF1976D2",
    "#FF1565C0",
    "#FF0D47A1",
  ];

  Color _themeColor = Colors.teal; // 当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor, // 用于导航栏、FloatingActionButton的背景等
        iconTheme: IconThemeData(color: _themeColor), // 用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("颜色和主题")),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                // 背景为蓝色，则title自动为白色
                child: NavBar(
                  color: Colors.blue,
                  title: "测试NavBar",
                  rightTitle: "default",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                // 背景为白色，则title自动为黑色
                child: NavBar(
                  color: Colors.white,
                  title: "测试NavBar",
                  rightTitle: "default",
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // 第一行Icon使用主题中的iconTheme
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.airport_shuttle),
                        Text(
                          "  颜色跟随主题",
                          style: TextStyle(color: _themeColor),
                        ),
                      ],
                    ),
                    // 第二行Icon自定义颜色(固定为黑色)
                    Theme(
                      data: themeData.copyWith(
                          iconTheme: themeData.iconTheme
                              .copyWith(color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.favorite),
                          Icon(Icons.airport_shuttle),
                          Text("  颜色固定黑色"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemExtent: 40,
                itemCount: blueColorsValue.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.zero,
                    child: NavBar(
                      color: blueColorsValue[index],
                      title: index <= 0 ? "50" : (index * 100).toString(),
                      rightTitle: blueColorsStringValue[index],
                    ),
                  );
                },
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // 切换主题
          onPressed: () => setState(() => _themeColor =
              _themeColor == Colors.teal ? Colors.blue : Colors.teal),
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}

/// 实现一个简单的自定义导航栏
class NavBar extends StatelessWidget {
  final String title;
  final Color color;
  String rightTitle;

  NavBar({Key, key, this.color, this.title, this.rightTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          // 阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: rightTitle == "default"
          ? Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // 根据背景颜色亮度来确定Title的颜色
                color: color.computeLuminance() < 0.5
                    ? Colors.white
                    : Colors.black,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // 根据背景颜色亮度来确定Title的颜色
                    color: color.computeLuminance() < 0.5
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Text(
                  rightTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // 根据背景颜色亮度来确定Title的颜色
                    color: color.computeLuminance() < 0.5
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              ],
            ),
      alignment: rightTitle == "default" ? Alignment.center : Alignment.center,
    );
  }
}
