import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';

class IconWithTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final Function()? onPressed;

  const IconWithTitle({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(icon), onPressed: () {}, color: AppColors.iconDark),
        Text(title,
            style: GoogleFonts.roboto(
                fontSize: 18,
                color: AppColors.textfieldTitle,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
