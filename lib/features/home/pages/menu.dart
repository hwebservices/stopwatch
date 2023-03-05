import 'package:stopwatch/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../widgets/botton_nav_bar.dart';

import '../../settings/pages/settings.dart';

import '../../stopwatch/pages/stopwatch_dashboard.dart';

/// This Class is handling the [Page Injection] in the CustomNavBar
class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Pages in the [CustomNavBar]
  static const List<Widget> _pages = <Widget>[
    HomeStopWatch(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar:
          CustomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
