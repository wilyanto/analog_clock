import 'dart:async';

import 'package:get/get.dart';

class ClockController extends GetxController {
  Rx<DateTime> _now = DateTime.now().obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _updateTime();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void _updateTime() {
    _now.value = DateTime.now();
    // Update once per second. Make sure to do it at the beginning of each
    // new second, so that the clock is accurate.
    _timer = Timer(
      const Duration(seconds: 1) -
          Duration(milliseconds: _now.value.millisecond),
      _updateTime,
    );
  }
}
