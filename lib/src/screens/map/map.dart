
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Карта'),
        border: Border(),
      ),
      child: Center(
        child: Text('Карта',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}