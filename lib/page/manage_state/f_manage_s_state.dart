import 'package:flutter/material.dart';

/// * Create by lf 2019-12-18 10:45
/// 父Widget管理子Widget的状态
/// 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父Widget管理
/// 在Widget内部管理状态封装性会好一些，而在父Widget中管理会比较灵活。
/// 有些时候，如果不确定到底该怎么管理状态，那么推荐的首选是在父widget中管理（灵活会显得更重要一些）

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _SonBoxWidget(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class _SonBoxWidget extends StatelessWidget {
  _SonBoxWidget({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}
