import 'dart:async';

import 'package:flutter/material.dart';

import 'time_service_provider.dart';

/// This Class will handle the methods that will interact with the [UI] using Provider
/// This is a simple [Provider] implementation, calling [notifyListners] to make changes
/// available to be consumed.
class TimerService extends ChangeNotifier {
  static TimerService of(context) {
    var provider =
        context.dependOnInheritedWidgetOfExactType<TimerServiceProvider>()
            as TimerServiceProvider;
    return provider.service!;
  }

  /// Declaring [stopwatch] and [timer] to contup the time
  final stopwatch = Stopwatch();
  Timer? timer;

  /// This getter will update the [duration]. The initial duration is [zero]
  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  /// This variable will help to implement the [button] behaviours
  bool isRunning = false;

  /// Implement the stopwatch [UPDATE]
  void updateStopwatch(Timer timer) {
    _currentDuration = stopwatch.elapsed;

    /// Uncomment the line below to see the ["Bug"]
    /// print(_currentDuration);
    notifyListeners();
  }

  /// Implement the stopwatch [START]
  void startStopwatch() {
    timer = Timer.periodic(Duration(milliseconds: 100), updateStopwatch);
    stopwatch.start();

    notifyListeners();
  }

  /// Implement the stopwatch [LAP]
  void lapStopwatch() {
    stopwatch.stop();
    _currentDuration = stopwatch.elapsed;
    assert(stopwatch.elapsed == _currentDuration);
    stopwatch.start();

    notifyListeners();
  }

  /// Implement the stopwatch [STOP]
  void stopStopwatch() {
    timer = null;
    stopwatch.stop();
    _currentDuration = stopwatch.elapsed;

    notifyListeners();
  }

  /// Implement the stopwatch [RESET]
  void resetStopwatch() {
    stopwatch.stop();
    timer?.cancel();
    stopwatch.reset();

    notifyListeners();
  }
}
