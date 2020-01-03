import 'package:flutter/material.dart';

/// * Create by lf 2019-12-18 10:37
/// 管理自身状态
/// 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由Widget本身来管理

class ManageSelfStateTab extends StatefulWidget {
  ManageSelfStateTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ManageSelfStateTab();
}

class _ManageSelfStateTab extends State<ManageSelfStateTab> {
  bool _active = false; // 颜色变化开关

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}
