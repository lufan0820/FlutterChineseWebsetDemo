import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lf_chinese_webset_demo/utils/toast_util.dart';

/// * Create by lf 2019-12-26 15:54
/// 对话框详解
///
/// TODO AlertDialog
/// 通过showDialog()方法来显示一个Material风格的Dialog，该方法返回一个Future
/// 如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，
/// 所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来。
///
/// TODO SimpleDialog
/// SimpleDialog也是Material组件库提供的对话框，它会展示一个列表，用于列表选择的场景
///
/// AlertDialog和SimpleDialog 由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
/// 导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
///
/// TODO Dialog
/// AlertDialog和SimpleDialog 内部都使用了Dialog
/// 如果需要嵌套ListView，则可以使用Dialog
///
/// TODO 对话框打开动画及遮罩
/// 我们可以把对话框分为内部样式和外部样式两部分
/// 内部样式指对话框中显示的具体内容，上面介绍的三种dialog已经说明
/// 外部样式包含对话框遮罩样式、打开动画等
///
/// showGeneralDialog()方法 打开一个普通风格的对话框(非Material风格)
/// showDialog正是showGeneralDialog的一个封装 定制了Material风格对话框的遮罩颜色和动画
///
/// TODO 对话框实现原理
/// 实现很简单，直接调用Navigator的push方法打开了一个新的对话框路由_DialogRoute，然后返回了push的返回值。
/// 可见对话框实际上正是通过路由的形式实现的，这也是为什么我们可以使用Navigator的pop 方法来退出对话框的原因
/// 详见showGeneralDialog方法源码
///
/// TODO 对话框状态管理
///
/// TODO 其它类型的对话框
/// TODO 底部菜单列表 showModalBottomSheet
/// showModalBottomSheet的实现原理和showGeneralDialog实现原理相同，都是通过路由的方式来实现的，读者可以查看源码对比。
///
/// TODO showBottomSheet
/// 该方法会从设备底部向上弹出一个全屏的菜单列表
/// PersistentBottomSheetController中包含了一些控制对话框的方法比如close方法可以关闭该对话框，功能比较简单，读者可以自行查看源码。
/// 唯一需要注意的是，showBottomSheet和我们上面介绍的弹出对话框的方法原理不同：
/// showBottomSheet是调用widget树顶部的Scaffold组件的ScaffoldState的showBottomSheet同名方法实现，
/// 也就是说要调用showBottomSheet方法就必须得保证父级组件中有Scaffold
///
/// TODO Loading框
/// 通过showDialog+AlertDialog来实现
///
/// TODO 日历选择
/// Material风格的日历选择器: showDatePicker
/// Cupertino(IOS)风格的日历选择器: showCupertinoModalPopup+CupertinoDatePicker

class TestDialogRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestDialogRoute();
}

class _TestDialogRoute extends State<TestDialogRoute> {
  // 复选框选中状态
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("对话框详解")),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                bool delete = await showDeleteConfirmAlertDialog();
                showToast(delete == null ? "取消删除" : "确认删除");
              },
              child: Text("AlertDialog"),
            ),
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                int result = await showChangeLanguageSimpleDialog();
                if (result != null) showToast(result == 1 ? "中文简体" : "美国英语");
              },
              child: Text("SimpleDialog"),
            ),
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                int result = await showListDialog();
                if (result != null) showToast("点击了: $result");
              },
              child: Text("Dialog"),
            ),
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                bool delete = await showCustomDeleteConfirmAlertDialog();
                showToast(delete == null ? "取消删除" : "确认删除");
              },
              child: Text("CustomDialog(缩放动画)"),
            ),
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                bool isCheck = await showDeleteConfirmWithCheckboxAlertDialog();
                showToast(isCheck == null ? "取消删除" : "确认删除,子目录是否删除: $isCheck");
              },
              child: Text("AlertDialogWithCheckbox"),
            ),
            RaisedButton(
              onPressed: () async {
                // 弹出对话框并等待期关闭
                int index = await _showModalBottomSheet();
                showToast(index == null ? "取消" : "$index");
              },
              child: Text("底部菜单列表"),
            ),
            Builder(builder: (context) {
              return RaisedButton(
                onPressed: () {
                  // 弹出对话框并等待期关闭
                  PersistentBottomSheetController<int> controller =
                      _showBottomSheet(context);
                  showToast(controller == null ? "取消" : "");
                },
                child: Text("底部全屏菜单列表"),
              );
            }),
            RaisedButton(
              onPressed: showLoadingDialog,
              child: Text("Loading框"),
            ),
            RaisedButton(
              onPressed: () {
                showMaterialDatePick().then((value) {
                  showToast(value.toLocal().toString());
                });
              },
              child: Text("Material风格日历选择器"),
            ),
          ].map((btn) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: btn,
            );
          }).toList(),
        ),
      ),
    );
  }

  // 弹出AlertDialog对话框
  Future<bool> showDeleteConfirmAlertDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
              child: Text("取消"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true), // 关闭对话框
              child: Text("删除"),
            ),
          ],
        );
      },
    );
  }

  // 弹出SimpleDialog对话框
  Future<int> showChangeLanguageSimpleDialog() {
    return showDialog<int>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("请选择语言"),
            children: <Widget>[
              // SimpleDialogOption 它相当于一个FlatButton，只不过按钮文案是左对齐的，并且padding较小
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("中文简体"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 2),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("美国英语"),
                ),
              ),
            ],
          );
        });
  }

  // 弹出Dialog(子组件是ListView)
  Future<int> showListDialog() {
    return showDialog<int>(
        context: context,
        builder: (context) {
          var child = Column(
            children: <Widget>[
              ListTile(title: Text("请选择")),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.pop(context, index),
                    );
                  },
                ),
              ),
            ],
          );
          // TODO flutter中文网中的例子说：这里使用AlertDialog会报错
          // TODO 我试了下，把Dialog换成AlertDialog并没有报错，也许是Flutter新版本(Flutter 1.12.13+hotfix.5 • channel stable •)中AlertDialog也可以嵌套ListView了？
          return Dialog(child: child);

          /// Dialog(child: child)可以替换成下面的代码
          /// 实现的效果一样，只是高度会发生一些变化
          /**return UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
              child: child,
              type: MaterialType.card,
              ),
              ),
              );**/
        });
  }

  // 使用showCustomDialog方法显示‘确认删除’的AlertDialog
  Future<bool> showCustomDeleteConfirmAlertDialog() {
    return showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
              child: Text("取消"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true), // 关闭对话框
              child: Text("删除"),
            ),
          ],
        );
      },
    );
  }

  // 弹出AlertDialog(内容中包含Checkbox)对话框
  Future<bool> showDeleteConfirmWithCheckboxAlertDialog() {
    bool _isCheckOne = false; // 默认不选中
    bool _isCheckTwo = false; // 默认不选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 表示子元素在主轴尽可能少的占用水平空间
            children: <Widget>[
              Text("您确定要删除当前文件吗？"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  // 通过Builder来获取构建Checkbox的`context`
                  // 这是一种常用的缩小`context`范围的方式
                  // 这样做的目的是让UI重构时，只重构Checkbox，而不是重构整个对话框组件
                  Builder(
                    builder: (context) {
                      return Checkbox(
                        value: _isCheckOne,
                        onChanged: (bool value) {
                          // 复选框选中状态发送变化时重新构建UI
                          setState(() {
                            // 此时context为对话框UI的根Element，我们直接将对话框UI对应的Element标记为dirty
                            // 现在只需要简单的认为：在组件树中，context实际上就是Element对象的引用。
                            // 如果上面不使用Builder，则会重构整个对话框组件
                            (context as Element).markNeedsBuild();
                            // 更新复选框状态
                            _isCheckOne = !_isCheckOne;
                          });
                        },
                      );
                    },
                  ),
                  // 使用StatefulBuilder来构建StatefulWidget上下文
                  StatefulBuilder(
                    builder: (context, _setState) {
                      return DialogCheckbox(
                        value: _isCheckTwo, // 默认不选中
                        onChanged: (bool value) {
                          _setState(() {
                            // 更新选中的状态
                            _isCheckTwo = !_isCheckTwo;
                          });
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("取消"),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, _isCheckOne),
              child: Text("确定"),
            ),
          ],
        );
      },
    );
  }

  // 弹出底部菜单列表
  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(title: Text("底部菜单列表")),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.pop(context, index),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Loading弹框
  showLoadingDialog() {
    // 因为showDialog已经限定了宽度
    // 所以要自定义宽度的话，使用UnconstrainedBox抵消宽度的限制，再使用SizedBox限定宽度
    return showDialog(
        context: context,
        barrierDismissible: false, // 点击遮罩层不关闭对话框
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 260,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(strokeWidth: 2),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "正在加载，请稍后...",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Material风格日历选择器
  Future<DateTime> showMaterialDatePick() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(days: 360)), // 未来360天可选
    );
  }

  // Cupertino(IOS)风格的日历选择器
  // ignore: slash_for_doc_comments
  /**
      /// 因为当前国际化，语言是zh，这里会报错；暂时没有找到解决办法
      Future<DateTime> showCupertinoDatePick() {
      return showCupertinoModalPopup(
      context: context,
      builder: (context) {
      return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      maximumYear: DateTime.now().year,
      minimumYear: 1950,
      onDateTimeChanged: (DateTime value) {
      print("$value");
      },
      ),
      );
      },
      );
      }
   **/

  // 弹出底部全屏菜单列表
  // 返回的是一个Controller
  PersistentBottomSheetController<int> _showBottomSheet(BuildContext context) {
    return showBottomSheet<int>(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              ListTile(title: Text("底部全屏菜单列表")),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () {
                        showToast("$index");
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  // 封装一个显示dialog的方法，打开/关闭的动画为缩放动画
  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData themeData = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return themeData != null
                ? Theme(data: themeData, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      // 自定义遮罩颜色
      transitionDuration: Duration(milliseconds: 150),
      transitionBuilder: _builderMaterialDialogTransitions,
    );
  }

  Widget _builderMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }
}

/// TODO 封装一个 管理自身状态的Checkbox， 以此解决Checkbox在对话框中不能选中的问题(不是最优的解决办法)
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({Key key, this.value, @required this.onChanged})
      : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        // 将选中的状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          // 更新自身
          value = v;
        });
      },
    );
  }
}
