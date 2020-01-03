import 'dart:collection';

import 'package:flutter/material.dart';

import 'goods.dart';

/// * Create by lf 2019-12-25 17:00
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<GoodsItem> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<GoodsItem> get items => UnmodifiableListView(_items);

  // 购物车中的商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将[item]添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(GoodsItem item) {
    _items.add(item);
    // 通知监听器(订阅者),重新构建InheritedProvider，更新状态。
    notifyListeners();
  }
}
