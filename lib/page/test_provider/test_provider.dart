import 'package:flutter/material.dart';

import 'change_notifier_provider.dart';
import 'goods.dart';
import 'save_item_model.dart';
import 'test_consumer.dart';

/// * Create by lf 2019-12-25 16:41
/// 跨组件状态共享
/// TODO Provider
/// 详见: https://book.flutterchina.club/chapter7/provider.html
///
/// 实战中还是Provider Package
/// 这两个包都是基于InheritedWidget的 原理和test_provider相似 Provider(https://pub.flutter-io.cn/packages/provider) & Scoped Model(https://pub.flutter-io.cn/packages/scoped_model)

// 实现一个简单的购物车
class TestProviderRoute extends StatefulWidget {
  @override
  _TestProviderRouteState createState() => _TestProviderRouteState();
}

class _TestProviderRouteState extends State<TestProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("跨组件状态共享"),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Consumer<CartModel>(
                    builder: (BuildContext context, cart) =>
                        Text("总价: ${cart.totalPrice}"),
                  ),
                  Builder(builder: (context) {
                    print("RaisedButton build");
                    return RaisedButton(
                      child: Text("添加商品"),
                      onPressed: () {
                        // listen设为false，不建立依赖关系
                        // 给购物车中添加商品，添加后总价会增加
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            .add(GoodsItem(20.0, 1));
                      },
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
