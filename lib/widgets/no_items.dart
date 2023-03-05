import 'package:flutter/material.dart';
import 'package:stopwatch/widgets/custom_text.dart';

class NoItemsScreen extends StatelessWidget {
  const NoItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/nodata.png",
          width: 100,
          height: 100,
        ),
        CustomText(text: 'No data available', fontSize: 16)
      ],
    );
  }
}
