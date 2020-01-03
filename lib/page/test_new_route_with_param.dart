import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 14:19
class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                  onPressed: () => Navigator.pop(context, "我是返回值"),
                  child: Text("返回"))
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          // 打开TipRoute，并等待返回结果
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(text: "我是提示.....");
          }));
          print("路由器返回值: $result");
        },
        child: Text("打开提示页"),
      ),
    );
  }
}
