import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/app_provider.dart';

/// This is the [Landing Page] where the users are redirect when the app run
class HomePage extends StatelessWidget {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [provider] will handle the theme and maintain persitence
    /// This is the part I don't like in the [Provider] :=( because calling it from within
    /// the build will make the inteire [UI] to update
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/dash.gif',
                width: 330,
                height: 330,
                gaplessPlayback: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
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
                  onPressed: () => context.go('/onboarding'),
                  child: Text('Start',
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: appProvider.isDark
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
