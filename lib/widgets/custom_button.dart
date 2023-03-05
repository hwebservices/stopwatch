import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
