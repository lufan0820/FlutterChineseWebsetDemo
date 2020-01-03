/// * Create by lf 2019-12-17 17:04
/// 在Widget树中获取State对象
/// 2.通过GlobalKey
/// 2.1给目标StatefulWidget添加GlobalKey
/// 定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
/// ```
/// static GlobalKey<ScaffoldState> _globalKey= GlobalKey();
/// ...
/// Scaffold(
///    key: _globalKey , //设置key
///    ...
/// )
/// ```
///
/// 2.2 通过GlobalKey来获取State对象
/// ```
/// _globalKey.currentState.openDrawer()
/// ```
