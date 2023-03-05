import 'package:flutter/material.dart';

import 'stopwatch_provider.dart';

/// Found this solution to handle to proper propagation of the [provider] in the widget tree
/// This class will serve as base [provider] for the [timer service]
class TimerServiceProvider extends InheritedWidget {
  const TimerServiceProvider({this.service, required super.child});

  final TimerService? service;

  @override
  bool updateShouldNotify(TimerServiceProvider old) => service != old.service;
}
