
import 'package:auth/src/screens/profile/repository/src/repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/screens/auth/repository/src/repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tokens');
  runApp(App(
    connectivity: Connectivity(),
    registerRepository: RegisterRepositoryImpl(),
    loginRepository: LoginRepositoryImpl(),
    profileRepository:ProfileRepositoryImpl()
  ));
}
