import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helpers.dart';

CupertinoThemeData theme() {
  return const CupertinoThemeData(
    primaryColor: Color(0xFF4631D2),
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontFamily: 'Manrope',fontWeight: FontWeight.bold),
      navTitleTextStyle: appBarStyle,
    ),
    barBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Color.fromRGBO(243, 244, 246, 1),
  );
}
