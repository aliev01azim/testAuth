
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Лента'),
      ),
      child: Center(
        child: Text('Лента',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}