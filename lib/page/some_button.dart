import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

/// * Create by lf 2019-12-18 15:12
/// TODO RaisedButton
/// 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
///
/// TODO FlatButton
/// FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
///
/// TODO OutlineButton
/// OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
///
/// TODO IconButton
/// IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
///
/// TODO 带图标的按钮
/// RaisedButton、FlatButton、OutlineButton都有一个icon 构造函数，通过它可以轻松创建带图标的按钮
///
/// TODO 自定义按钮外观
/// 详细的信息可以查看API文档
/// ```
// const FlatButton({
//  ...
//  @required this.onPressed, //按钮点击回调
//  this.textColor, //按钮文字颜色
//  this.disabledTextColor, //按钮禁用时的文字颜色
//  this.color, //按钮背景颜色
//  this.disabledColor,//按钮禁用时的背景颜色
//  this.highlightColor, //按钮按下时的背景颜色
//  this.splashColor, //点击时，水波动画中水波的颜色
//  this.colorBrightness,//按钮主题，默认是浅色主题
//  this.padding, //按钮的填充
//  this.shape, //外形
//  @required this.child, //按钮的内容
// })
/// ```
///
/// TODO 背景渐变的圆角按钮
/// 如果我们想实现一个背景渐变的圆角按钮，按钮有没有相应的属性呢？
/// 答案是否定的，但是，我们可以通过其它方式来实现，通过自定义组件来实现

class SomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("各种Button"),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      ToastUtil.showMsg("RaisedButton");
                    },
                    child: Text("RaisedButton"),
                  ),
                  FlatButton(
                    child: Text("FlatButton"),
                    onPressed: () {
                      ToastUtil.showMsg("FlatButton");
                    },
                  ),
                  OutlineButton(
                    child: Text("OutlineButton"),
                    onPressed: () {
                      ToastUtil.showMsg("OutlineButton");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {
                      ToastUtil.showMsg("IconButton");
                    },
                  ),
                  RaisedButton.icon(
                    label: Text("RaisedButtonWithIcon"),
                    icon: Icon(Icons.send),
                    onPressed: () {
                      ToastUtil.showMsg("RaisedButtonWithIcon");
                    },
                  ),
                  FlatButton.icon(
                    label: Text("FlatButtonWithIcon"),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      ToastUtil.showMsg("FlatButtonWithIcon");
                    },
                  ),
                  OutlineButton.icon(
                    label: Text("OutlineButtonWithIcon"),
                    icon: Icon(Icons.info),
                    onPressed: () {
                      ToastUtil.showMsg("OutlineButtonWithIcon");
                    },
                  ),
                  FlatButton(
                    color: Colors.blue,
                    // color: Color(0x000000), // 设置为透明 去除背景
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      ToastUtil.showMsg("BorderRadiusFlatButton");
                    },
                    child: Text("Submit"),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    //正常状态下的阴影
                    elevation: 5.0,
                    //按下时的阴影
                    highlightElevation: 10.0,
                    // 禁用时的阴影
                    disabledElevation: 0.0,
                    onPressed: () {
                      ToastUtil.showMsg("BorderRadiusFlatButtonWithShadow");
                    },
                    child: Text("SubmitWithShadow"),
                  )
                ])));
  }
}
