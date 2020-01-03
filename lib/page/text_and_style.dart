import 'package:flutter/material.dart';

/// * Create by lf 2019-12-18 11:28
/// 文本及样式
/// TODO textAlign
/// 文本的对齐方式；可以选择左对齐、右对齐还是居中。
/// 注意，对齐的参考系是Text widget本身
/// Text文本内容宽度不足一行，Text的宽度和文本内容长度相等，那么这时指定对齐方式是没有意义的
///
/// TODO maxLines、overflow
/// 指定文本显示的最大行数，默认情况下，文本是自动折行的，
/// 如果指定此参数，则文本最多不会超过指定的行。
/// 如果有多余的文本，可以通过overflow来指定截断方式，
/// 默认是直接截断，本例中指定的截断方式TextOverflow.ellipsis，它会将多余文本截断后以省略符“...”
///
/// TODO textScaleFactor
/// 代表文本相对于当前字体大小的缩放因子，
/// 相对于去设置文本的样式style属性的fontSize，它是调整字体大小的一个快捷方式。
/// 该属性的默认值可以通过MediaQueryData.textScaleFactor获得，
/// 如果没有MediaQuery，那么会默认值将为1.0
///
/// TODO TextStyle
/// TODO height
/// 该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于fontSize*height。
///
/// TODO fontFamily
/// 由于不同平台默认支持的字体集不同，所以在手动指定字体时一定要先在不同平台测试一下。
///
/// TODO fontSize
/// 该属性和Text的textScaleFactor都用于控制字体大小。但是有两个主要区别：
/// fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
/// textScaleFactor主要是用于系统字体大小设置改变时对Flutter应用字体进行全局调整，而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化
/// 其他属性详见SDK文档
///
/// TODO TextSpan
/// 如果我们需要对一个Text内容的不同部分按照不同的样式显示，
/// 这时就可以使用TextSpan，它代表文本的一个“片段”
///
/// TODO DefaultTextStyle
/// 在Widget树中，文本的样式默认是可以被继承的（子类文本类组件未指定具体样式时可以使用Widget树中父级设置的默认样式），
/// 因此，如果在Widget树的某一个节点处设置一个默认的文本样式，
/// 那么该节点的子树中所有文本都会默认使用这个样式，
/// 而DefaultTextStyle正是用于设置默认文本样式的
///
/// TODO 字体
/// 1.首先在pubspec.yaml中声明它们，以确保它们会打包到应用程序中。
/// 2.然后通过TextStyle属性使用字体(fontFamily: '字体名称')
/// ```
/// flutter:
///  fonts:
///   - family: Raleway
///      fonts:
///       - asset: assets/fonts/Raleway-Regular.ttf
///       - asset: packages/my_package/fonts/Raleway-Medium.ttf  // 声明的字体在某个package(my_package)内
///         weight: 500
/// ```
///
/// 如果声明的字体在某个package内，则使用字体时，需要指定包名 package:'包名'
/// ```
/// const textStyle = const TextStyle(
///  fontFamily: 'Raleway',
/// package: 'my_package', //指定包名
/// );
/// ```

class TextAndStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文本及样式"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello World", textAlign: TextAlign.left),
            Text("Hello World " * 6, textAlign: TextAlign.center),
            Text("Hello World " * 10,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            Text("Hello World", textScaleFactor: 2.1),
            Text(
              "Hello World",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: "Courier",
                background: new Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(color: Colors.blue)),
            ])),
            DefaultTextStyle(
                // 设置默认样式
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Hello World"),
                    Text("i am Jack"),
                    Text(
                      "i am Jack",
                      style: TextStyle(
                          inherit: false, // 不继承默认样式
                          color: Colors.grey),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
