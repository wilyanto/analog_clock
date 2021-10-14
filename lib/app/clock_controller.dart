import 'dart:async';

import 'package:get/get.dart';

class ClockController extends GetxController {
  Rx<DateTime> now = DateTime.now().obs;
  Rx<DateTime> tempDateTime = DateTime.now().obs;
  late Timer _timer;

  @override
  void onInit() {
    print('hellow');
    _updateTime();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void _updateTime() {
    now.value = DateTime.now();
    // Update once per second. Make sure to do it at the beginning of each
    // new second, so that the clock is accurate.
    _timer = Timer(
      const Duration(seconds: 1) -
          Duration(milliseconds: now.value.millisecond),
      _updateTime,
    );
  }

  void increaseHour() {
    tempDateTime.value = tempDateTime.value.add(const Duration(hours: 1));
  }

  void decreaseHour() {
    tempDateTime.value = tempDateTime.value.subtract(
      const Duration(hours: 1),
    );
  }

  void increaseMinute() {
    tempDateTime.value = tempDateTime.value.add(const Duration(minutes: 1));
  }

  void decreaseMinute() {
    tempDateTime.value = tempDateTime.value.subtract(
      const Duration(minutes: 1),
    );
  }
}
