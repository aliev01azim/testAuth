import 'package:auth/src/helpers/helpers.dart';
import 'package:auth/src/screens/profile/bloc/profile_bloc.dart';
import 'package:auth/src/screens/profile/widgets/logout_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileGetEvent(null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Профиль'),
        border: Border(),
      ),
      child: SafeArea(
        child: Material(
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Color(0xFF4631D2),
                ),
              );
            }
            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  h32,
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: SvgPicture.asset(
                      'assets/images/profile.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  h16,
                  Text(
                    state.user.nickname,
                    style: titleStyle,
                  ),
                  h12,
                  Text(
                    state.user.email,
                    style: subTitleStyle,
                  ),
                  h27,
                  const LogoutButton()
                ],
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
