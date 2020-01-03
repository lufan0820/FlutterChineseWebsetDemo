import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

/// * Create by lf 2019-12-19 11:58
/// TODO 输入框
///
/// TextField
/// 文本输入框
/// 属性详见: https://book.flutterchina.club/chapter3/input_and_form.html

class TextFieldTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFieldTestRoute();
}

class _TextFieldTestRoute extends State<TextFieldTestRoute> {
  TextEditingController _loginNameController = TextEditingController();

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();
  FocusNode focusNode4 = new FocusNode();

  FocusNode focusNode5 = new FocusNode();
  FocusNode focusNode6 = new FocusNode();

  FocusNode focusNode7 = new FocusNode();

  FocusScopeNode focusScopeNode;

  var node6HasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("输入框及表单"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 登录输入框
            TextField(
              autofocus: true,
              focusNode: focusNode1,
              controller: _loginNameController,
              // TODO 监听文本变化,第一种是通过onChanged监听
              onChanged: (v) {
                print("用户名(onChanged): $v");
              },
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入用户名或邮箱",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              focusNode: focusNode2,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入登录密码",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            // 自定义TextField样式
            TextField(
              focusNode: focusNode3,
              decoration: InputDecoration(
                  labelText: "自定义TextField1",
                  prefixIcon: Icon(Icons.info),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  // 获得焦点下划线设为黄色
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
            ),
            Theme(
                data: Theme.of(context).copyWith(
                  hintColor: Colors.green[200], // 定义下划线
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey), // 定义label字体样式
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 18.0), // 定义提示文本样式
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      focusNode: focusNode4,
                      decoration: InputDecoration(
                        labelText: "自定义TextField2",
                        hintText: "随便输点什么吧",
                        prefixIcon: Icon(Icons.camera),
                      ),
                    ),
                    TextField(
                      focusNode: focusNode5,
                      decoration: InputDecoration(
                          labelText: "自定义TextField3",
                          hintText: "随便输点什么吧",
                          prefixIcon: Icon(Icons.flash_auto),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0)),
                      obscureText: true,
                    ),
                  ],
                )),
            // 自定义TextField,隐藏下划线,自定义下划线
            Container(
              child: TextField(
                focusNode: focusNode6,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "请输入邮箱地址",
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none, // 隐藏下划线
                ),
              ),
              decoration: BoxDecoration(
                // 下划线浅灰色，宽度为10像素
                border: Border(
                  bottom: BorderSide(
                    color: node6HasFocus ? Colors.yellow[200] : Colors.red[200],
                    width: 2.0,
                  ),
                ),
              ),
            ),
            // 多行输入框
            Container(
              margin: EdgeInsets.all(20),
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1)),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150),
                child: TextField(
                  focusNode: focusNode7,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: '我是多行输入框',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  maxLines: null,
                ),
              ),
            ),
            RaisedButton(
              child: Text("登录"),
              onPressed: () {
                showToast("用户名: ${_loginNameController.text}");
              },
            ),
            RaisedButton(
              child: Text("移动焦点"),
              onPressed: () {
                // 将焦点从第一个TextField移动到第二个TextField
                // 第一种写法
                // FocusScope.of(context).requestFocus(focusNode2);
                // 第二种写法
                if (null == focusScopeNode) {
                  focusScopeNode = FocusScope.of(context);
                }
                if (focusNode1.hasFocus) {
                  focusScopeNode.requestFocus(focusNode2);
                } else {
                  focusScopeNode.requestFocus(focusNode1);
                }
              },
            ),
            RaisedButton(
              child: Text("隐藏键盘"),
              onPressed: () {
                // 当所有输入框都是去焦点时键盘就会收起
                focusNode1.unfocus();
                focusNode2.unfocus();
                focusNode3.unfocus();
                focusNode4.unfocus();
                focusNode5.unfocus();
                focusNode6.unfocus();
                focusNode7.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loginNameController.text = "hello world";
    _loginNameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _loginNameController.text.length);

    // TODO 监听文本变化,第二种是通过controller监听
    _loginNameController.addListener(() {
      print("用户名(Controller): ${_loginNameController.text}");
    });

    // TODO 监听焦点变化
    focusNode6.addListener(() {
      setState(() {
        node6HasFocus = focusNode6.hasFocus;
      });
    });
  }
}
