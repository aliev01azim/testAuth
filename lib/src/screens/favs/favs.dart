
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavsTab extends StatelessWidget {
  const FavsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Избранные'),
        border: Border(),
      ),
      child: Center(
        child: Text('Избранные',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}