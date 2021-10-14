import 'package:flutter/material.dart';
import 'package:flutter_clock/app/clock_controller.dart';
import 'package:flutter_clock/ui/widgets/instructions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../widgets/clock_ticks.dart';
import '../../utils/constants.dart';
import '../widgets/drawn_hand.dart';

class AppMainPage extends HookWidget {
  const AppMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ClockController clockController;
    useEffect(() {
      clockController = Get.put(ClockController());
    });

    int sensitivity = 8;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final unit = constraints.biggest.width / 50;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > sensitivity) {
                    clockController.increaseHour();
                  } else if (details.delta.dx < -sensitivity) {
                    clockController.decreaseHour();
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > sensitivity) {
                    clockController.increaseMinute();
                  } else if (details.delta.dy < -sensitivity) {
                    clockController.decreaseMinute();
                  }
                },
                child: Column(
                  children: [
                    const Instructions(),
                    Obx(
                      () => Text(
                        '${clockController.tempDateTime.value.hour < 10 ? '0${clockController.tempDateTime.value.hour}' : clockController.tempDateTime.value.hour}:${clockController.tempDateTime.value.minute < 10 ? '0${clockController.tempDateTime.value.minute}' : clockController.tempDateTime.value.minute}',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-unit / 2, -unit / 2),
                              blurRadius: 1.5 * unit,
                            ),
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(unit / 2, unit / 2),
                              blurRadius: 1.5 * unit,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClockTicks(unit: unit * 1.75),
                            DrawnHand(
                              color: Colors.red,
                              thickness: 2,
                              size: 0.7,
                              angleRadians: clockController.now.value.second *
                                  radiansPerTick,
                            ),
                            DrawnHand(
                              color: Colors.black,
                              thickness: 4,
                              size: 0.7,
                              angleRadians:
                                  clockController.tempDateTime.value.minute *
                                      radiansPerTick,
                            ),
                            DrawnHand(
                              color: Colors.black,
                              thickness: 8,
                              size: 0.4,
                              angleRadians: clockController
                                          .tempDateTime.value.hour *
                                      radiansPerHour +
                                  (clockController.tempDateTime.value.minute /
                                          60) *
                                      radiansPerHour,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Text(
                          'Set Alarm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
