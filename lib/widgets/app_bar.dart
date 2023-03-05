import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../config/app_provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  static const _defaultHeight = 56.0;

  final double elevation;
  final Gradient? gradient;
  final String title;
  final double barHeight;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;

  CustomAppBar({
    super.key,
    required this.title,
    this.elevation = 3.0,
    this.gradient,
    this.barHeight = _defaultHeight,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, elevation),
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3)
            ]),
        child: AppBar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: Text(
            title,
            style: GoogleFonts.roboto(
                fontSize: 20,
                color: appProvider.isDark
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w500),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: actions,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
