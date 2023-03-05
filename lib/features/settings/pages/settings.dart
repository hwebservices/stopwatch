import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../config/app_provider.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/icon_title.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    /// Inject the provider to handle the [DARK MODE] theme
    final appProvider = Provider.of<AppProvider>(context);
    return CustomScaffold(
      appBar: CustomAppBar(
        title: "Settings",
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserAvatar(),
        ),
      ),
      body: Column(
        children: [
          const IconWithTitle(title: 'Settings', icon: Icons.settings),
          CustomCard(
            child: ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: Text('Dark Mode'),
              trailing: Switch(
                inactiveTrackColor: Colors.grey,
                value: appProvider.isDark,
                onChanged: (value) {
                  appProvider
                      .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const IconWithTitle(
              title: 'Subscription', icon: FontAwesomeIcons.moneyBillWheat),
          CustomCard(
            child: ListTile(
                leading: const Icon(FontAwesomeIcons.bitcoinSign),
                title: Text('Basic - Always Free'),
                trailing:
                    ElevatedButton(onPressed: null, child: Text('Upgrade'))),
          ),
        ],
      ),
    );
  }
}
