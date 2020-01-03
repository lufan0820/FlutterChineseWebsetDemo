import 'package:flutter/material.dart';

/// * Create by lf 2019-12-19 11:46
/// TODO 单选开关和复选框
///
/// TODO Switch
/// activeColor属性，用于设置激活态的颜色
/// 其他属性见SDK文档
/// 只能定义宽度，高度也是固定的
///
/// TODO Checkbox
/// activeColor属性，用于设置激活态的颜色
/// 其他属性见SDK文档
/// 大小是固定的，无法自定义

class SwitchAndCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchAndCheckBoxState();
}

class _SwitchAndCheckBoxState extends State<SwitchAndCheckBox> {
  bool _switchSelected = true; // 维护单选开关状态
  bool _checkBoxSelected = true; // 维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单选开关和复选框"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Switch(
                  value: _switchSelected,
                  onChanged: (value) {
                    // 重新构建页面
                    setState(() {
                      _switchSelected = value;
                    });
                  }),
              Text(_switchSelected ? "开" : "关")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                  value: _checkBoxSelected,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _checkBoxSelected = value;
                    });
                  }),
              Text(_checkBoxSelected ? "选中" : "未选中")
            ],
          )
        ],
      ),
    );
  }
}
