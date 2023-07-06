import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: Color.fromRGBO(224, 230, 237, 1),
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}
