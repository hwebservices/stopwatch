import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_provider.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.elevation,
    required this.child,
  });

  final double? elevation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            color: appProvider.isDark
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor,
            child: child));
  }
}
