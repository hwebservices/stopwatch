import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:stopwatch/widgets/app_bar.dart';
import 'package:stopwatch/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch/widgets/custom_text.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

/// This page was meant to check [simulate] an intermidiary step where we need to check
/// the [permissions]. This step is particularly important when the app will need to connect to
/// external devices, get current [position] and so on...
class _OnboardingState extends State<Onboarding> {
  /// Promise to initialize [timer] at the compile time
  late Timer _timer;
  bool isGranted = false;

  @override
  void initState() {
    super.initState();

    /// This timer will [simulate] the time the app needs to check the permissions
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      setState(() {
        isGranted = true;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Permissions'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGranted
                ? Column(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.done,
                            color: Colors.green, size: 20),
                        label: Text(
                          'All permissions granted 😁',
                          style: GoogleFonts.roboto(
                              fontSize: 22,
                              color: Color.fromARGB(255, 1, 22, 1),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () => context.go('/menu'),
                            child: CustomText(text: "Lets GO!", fontSize: 20)),
                      )
                    ],
                  )
                : Column(
                    children: [
                      CustomText(
                          text: 'Simulating permissions request', fontSize: 18),
                      const SizedBox(height: 40),
                      const CircularProgressIndicator(color: Colors.red),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
