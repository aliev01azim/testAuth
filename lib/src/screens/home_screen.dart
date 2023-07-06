import 'package:auth/src/screens/favs/favs.dart';
import 'package:auth/src/screens/map/map.dart';
import 'package:auth/src/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auth/src/screens/auth/repository/auth_repository.dart';
import 'package:flutter_svg/svg.dart';

import 'feed/feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.user});
  final UserModel? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [
    const FeedTab(),
    const MapTab(),
    const FavsTab(),
    const ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            _getIcon('feed', 'Лента'),
            _getIcon('map', 'Карта'),
            _getIcon('like', 'Избранные'),
            _getIcon('profile', 'Профиль'),
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          return _tabs[index];
        });
  }

  BottomNavigationBarItem _getIcon(String path, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/$path.svg',
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
      label: label,
      activeIcon: SvgPicture.asset('assets/images/$path.svg',
          colorFilter:
              const ColorFilter.mode(Color(0xFF4631D2), BlendMode.srcIn)),
    );
  }
}
