import 'package:flutter/material.dart';

/// * Create by lf 2020-01-06 14:50
/// Hero动画
/// Hero指的是可以在路由(页面)之间'飞行'的widget，简单来说Hero动画就是在路由切换时，有一个共享的widget可以在新旧路由间切换。
/// 由于共享的widget在新旧路由页面上的位置、外观可能有所差异，所以在路由切换时会从旧路由逐渐过渡到新路由中的指定位置，就这样会产生一个Hero动画。
///
/// 你可能多次看到过 hero 动画。
/// 例如，一个路由中显示待售商品的缩略图列表，选择一个条目会将其跳转到一个新路由，新路由中包含该商品的详细信息和“购买”按钮。
/// 在Flutter中将图片从一个路由“飞”到另一个路由称为hero动画，尽管相同的动作有时也称为 共享元素转换

/// 示例:
/// A路由: 包含一个用户头像、圆形、点击后跳到B路由
/// B路由: 显示用户头像原图，矩形
///
/// 我们可以看到，实现Hero动画只需要用Hero组件将要共享的widget包装起来，
/// 并提供一个相同的tag即可，中间的过渡帧都是Flutter Framework自动完成的。
/// 必须要注意，前后路由页的共享Hero的tag必须是相同的，Flutter Framework内部正是通过tag来确定新旧路由页widget的对应关系的

class TestHeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero动画(路由A)")),
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset("images/sia_girl.png", width: 50),
            ),
          ),
          onTap: () {
            // 打开路由B
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: _HeroAnimationRouteB(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("原图(路由B)")),
      body: Center(
        child: Hero(
          tag: "avatar", // 唯一标记，前后两个路由Hero的tag必须相同
          child: Image.asset("images/sia_girl.png"),
        ),
      ),
    );
  }
}
