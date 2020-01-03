import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// * Create by lf 2019-12-17 15:28

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
        padding: const EdgeInsets.all(8.0), child: Text(wordPair.toString()));
  }
}
