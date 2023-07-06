import 'package:auth/src/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/auth_screen.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../bloc/profile_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
              onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const AuthScreen()),
            (_) => false,
          );
          context.read<ProfileBloc>().add(ProfileReset());
          context.read<AuthBloc>().add(AuthLogoutEvent());
        },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
        child: const Text(
          'Выйти',
          style: logOutStyle,
        ),
      ),
    );
  }
}
