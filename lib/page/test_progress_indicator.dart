import 'package:flutter/material.dart';

/// * Create by lf 2019-12-19 16:49
/// TODO 进度指示器
/// LinearProgressIndicator 和 CircularProgressIndicator，
/// 它们都可以同时用于精确的进度指示和模糊的进度指示。
/// 精确进度通常用于任务进度可以计算和预估的情况，比如文件下载；
/// 而模糊进度则用户任务进度无法准确获得的情况，如下拉刷新，数据提交等
///
/// TODO 自定义进度指示器样式
/// 定制进度指示器风格样式，可以通过CustomPainter Widget 来自定义绘制逻辑，
/// 实际上LinearProgressIndicator和CircularProgressIndicator也正是通过CustomPainter来实现外观绘制的。

class ProgressIndicatorRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgressIndicatorRoute();
}

class _ProgressIndicatorRoute extends State<ProgressIndicatorRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // 动画执行3秒
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.value = 0;
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("进度指示器"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 模糊进度条(会执行一个动画)
              LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              // 进度条显示50%
              LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
              // 圆形进度条
              // 模糊进度条
              CircularProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
              // 进度条显示50%,会显示一个半圆
              CircularProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: .5,
                strokeWidth: 10,
              ),
              // 线性进度条高度指定为3
              SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              ),
              // 圆形进度条直径指定为100
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  value: .7,
                ),
              ),
              // TODO 注意 圆形进度条 如果宽度!=高度，会显示成椭圆
              SizedBox(
                width: 150,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  value: .5,
                ),
              ),
              // 实现进度条在3秒内
              // 由0变为100的动画效果
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                      .animate(_animationController), // 从灰色变为蓝色
                  value: _animationController.value,
                ),
              ),
            ].map((e) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: e,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
