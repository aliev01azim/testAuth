import 'package:auth/src/helpers/helpers.dart';
import 'package:auth/src/screens/home_screen.dart';
import 'package:auth/src/screens/profile/bloc/profile_bloc.dart';
import 'package:auth/src/screens/profile/repository/src/repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'internet_cubit/internet_cubit.dart';
import 'screens/auth/bloc/auth_bloc.dart';
import 'screens/auth/repository/auth_repository.dart';
import 'screens/auth/auth_screen.dart';
import 'widgets/widgets.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required this.connectivity,
      required this.registerRepository,
      required this.profileRepository,
      required this.loginRepository});
  final Connectivity connectivity;
  final RegisterRepositoryImpl registerRepository;
  final LoginRepositoryImpl loginRepository;
  final ProfileRepositoryImpl profileRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (_) => AuthBloc(
            registerRepository: registerRepository,
            loginRepository: loginRepository,
          ),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(
            profileRepository: profileRepository,
          ),
        ),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: theme(),
        home: Builder(builder: (context) {
          return BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetDisconnectedState) {
                  showCupertinoSnackBar(
                      context: context, message: 'Отсутствует интернет!');
                }
              },
              child: ValueListenableBuilder(
                  valueListenable: Hive.box('tokens').listenable(),
                  builder: (context, box, widget) {
                    return box.get('data')?['accessToken'] == null
                        ? const AuthScreen()
                        : const HomeScreen();
                  }));
        }),
      ),
    );
  }


}
