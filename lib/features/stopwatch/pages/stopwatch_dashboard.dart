import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:stopwatch/util/utils.dart';
import 'package:stopwatch/widgets/app_bar.dart';
import 'package:stopwatch/widgets/custom_card.dart';
import 'package:stopwatch/widgets/custom_scaffold.dart';
import 'package:stopwatch/widgets/custom_text.dart';
import 'package:stopwatch/widgets/icon_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stopwatch/widgets/no_items.dart';

import '../../../config/app_colors.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/message_dialog.dart';
import '../provider/stopwatch_provider.dart';

/// This is the main [Page] where all the main interaction with the app will happen
class HomeStopWatch extends StatefulWidget {
  const HomeStopWatch({super.key});

  @override
  State<HomeStopWatch> createState() => _HomeStopWatchState();
}

class _HomeStopWatchState extends State<HomeStopWatch> {
  List<String> laps = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Inject the initial [PROVIDER] state
    final timerService = TimerService.of(context);
    return CustomScaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserAvatar(),
        ),
        title: "⏱️ Stopwatch ⏱️",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IconWithTitle(title: 'Device', icon: Icons.watch),
            Column(
              children: [
                CustomCard(
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.bluetooth),
                    title: Text('Henry Michels Apple Watch'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MessageDialog(
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                      'You need to upgrade to have access to this functionality'),
                                ),
                                stopCallBack: () {
                                  Navigator.of(context).pop();
                                },
                                title:
                                    Center(child: Text('🔥 Subscription 🔥')),
                              );
                            });
                      },
                      child: const Text('Connect'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const IconWithTitle(title: 'Timer', icon: Icons.timelapse),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: CustomText(
                        text: timerService.isRunning == true
                            ? 'Running'
                            : 'Stopped',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: timerService.isRunning == true
                            ? Colors.greenAccent
                            : Colors.red,
                      ),
                    )
                  ],
                ),

                /// The timer counting up with [stopwatch] showing the time progress
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: CustomCard(
                    child: Center(
                      /// Found this Widget that will subscribe the [provider] and handle the changes
                      child: AnimatedBuilder(
                        animation: timerService,
                        builder: (context, child) {
                          return CustomText(
                            text: Utils.fromDuration(
                                timerService.currentDuration),
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Display 4 buttons based on the type of [Dependency] to be inject
                /// Button are displayed based on the [state.isRunning] true or false
                /// and the take the same position in the screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Evaluate the [state.isRunning]
                    timerService.isRunning == false
                        ? CustomButtom(
                            onPressed: () {
                              timerService.startStopwatch();
                              setState(() {
                                timerService.isRunning = true;
                              });
                            },
                            child: CustomText(text: 'Start', fontSize: 16))
                        : CustomButtom(
                            onPressed: () {
                              setState(() {
                                timerService.isRunning = false;
                              });
                              timerService.stopStopwatch();
                            },
                            child: CustomText(text: 'Stop', fontSize: 16)),

                    /// Evaluate the [state.isRunning]
                    timerService.isRunning == true
                        ? CustomButtom(
                            onPressed: () {
                              timerService.lapStopwatch();
                              setState(() {
                                timerService.isRunning = true;
                              });
                              laps.add(Utils.fromDuration(
                                  timerService.currentDuration));
                            },
                            child: CustomText(text: 'Lap', fontSize: 16))
                        : CustomButtom(
                            onPressed:
                                timerService.currentDuration == Duration.zero
                                    ? null
                                    : () {
                                        timerService.resetStopwatch();
                                        laps.clear();
                                        setState(() {
                                          timerService.isRunning = false;
                                        });
                                      },
                            child: CustomText(
                              text: 'Reset',
                              fontSize: 16,
                            ),
                          )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const IconWithTitle(
                    title: 'Lap(s)  =>', icon: Icons.timer_sharp),
                const SizedBox(width: 10),
                Text('(Total ${laps.length} )',
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: AppColors.textfieldTitle,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            laps.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 30),
                      NoItemsScreen(),
                    ],
                  )
                : ListView.builder(
                    primary: false,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: laps.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lap ${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${laps.elementAt(index)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
