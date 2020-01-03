import 'package:flutter/material.dart';

/// * Create by lf 2019-12-18 16:27
/// 图片以及Icon
/// TODO Image
/// Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M
///
/// TODO width、height
/// 用于设置图片的宽、高，当不指定宽高时，
/// 图片会根据当前父容器的限制，尽可能的显示其原始大小，
/// 如果只设置width、height的其中一个
/// 那么另一个属性默认会按比例缩放，但可以通过下面介绍的fit属性来指定适应规则。
///
/// TODO fit
/// 该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式。
/// 适应模式是在BoxFit中定义，它是一个枚举类型，有如下值：
/// fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
/// cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
/// contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
/// fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
/// fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
/// none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分
///
/// TODO color 和 colorBlendMode
/// 在图片绘制时可以对每一个像素进行颜色混合处理，
/// color指定混合色
/// colorBlendMode指定混合模式
///
/// TODO ICON
///
/// 在Flutter开发中，iconfont和图片相比有如下优势：
/// 体积小：可以减小安装包大小。
/// 矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
/// 可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
/// 可以通过TextSpan和文本混用
///
/// TODO 使用自定义字体图标
/// 导入字体图标文件

class ImageAndIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片以及Icon"),
      ),
      body: SingleChildScrollView(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              children: <Widget>[
            Image(
              image: AssetImage("images/1.png"),
              width: 50.0,
              height: 100.0,
              fit: BoxFit.fill,
            ),
            Image.asset(
              "images/1.png",
              width: 50.0,
              height: 50.0,
              fit: BoxFit.contain,
            ),
            Image(
              image: AssetImage("images/1.png"),
              width: 100.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "images/1.png",
              width: 100.0,
              height: 50.0,
              fit: BoxFit.fitWidth,
            ),
            Image(
              image: AssetImage("images/1.png"),
              width: 100.0,
              height: 50.0,
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              "images/1.png",
              width: 100.0,
              height: 50.0,
              fit: BoxFit.scaleDown,
            ),
            Image.asset(
              "images/1.png",
              width: 50.0,
              height: 100.0,
              fit: BoxFit.none,
            ),
            Image(
              image: AssetImage("images/1.png"),
              width: 100.0,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
              fit: BoxFit.fill,
            ),
            Image(
              image: AssetImage("images/1.png"),
              width: 100.0,
              height: 200.0,
              repeat: ImageRepeat.repeatY,
            ),
            Image(
              image: NetworkImage(
                  "http://zcmlcimg.oss-cn-hangzhou.aliyuncs.com/1.png"),
              width: 150.0,
            ),
            Image.network(
              "http://zcmlcimg.oss-cn-hangzhou.aliyuncs.com/1.png",
              width: 200.0,
            )
          ].map((e) {
            return Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 100, // 限制了每个组件的宽度
                    child: e,
                  ),
                )
              ],
            );
          }).toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.accessible, color: Colors.green),
              Icon(Icons.error, color: Colors.green),
              Icon(Icons.fingerprint, color: Colors.green),
            ],
          )
        ],
      )),
    );
  }
}
