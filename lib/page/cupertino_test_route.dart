import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 17:24
/// cupertino风格的组件

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Cupertino Demo"),
        ),
        child: Center(
          child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text("Press"),
              onPressed: () => print("Press")),
        ));
  }
}
