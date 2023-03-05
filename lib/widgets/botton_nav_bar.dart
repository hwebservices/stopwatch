import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BottomNavigationBar(
      backgroundColor: appProvider.isDark
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.primary,
      selectedItemColor: appProvider.isDark
          ? Theme.of(context).highlightColor
          : Theme.of(context).highlightColor,
      unselectedItemColor: appProvider.isDark
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorLight,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
