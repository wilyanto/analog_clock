import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock/utils/theme.dart';

import '../widgets/clock_ticks.dart';
import '../../utils/constants.dart';
import '../widgets/drawn_hand.dart';

class AppMainPage extends StatefulWidget {
  const AppMainPage({Key? key}) : super(key: key);

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  var _now = DateTime.now();
  late DateTime _tempDateTime;

  late Timer _timer;

  @override
  void initState() {
    _tempDateTime = _now;
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    int sensitivity = 8;

    void increaseHour() {
      setState(() {
        _tempDateTime = _tempDateTime.add(const Duration(hours: 1));
      });
    }

    void decreaseHour() {
      setState(() {
        _tempDateTime = _tempDateTime.subtract(const Duration(hours: 1));
      });
    }

    void increaseMinute() {
      setState(() {
        _tempDateTime = _tempDateTime.add(const Duration(minutes: 1));
      });
    }

    void decreaseMinute() {
      setState(() {
        _tempDateTime = _tempDateTime.subtract(const Duration(minutes: 1));
      });
    }

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
                    increaseHour();
                  } else if (details.delta.dx < -sensitivity) {
                    decreaseHour();
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > sensitivity) {
                    increaseMinute();
                  } else if (details.delta.dy < -sensitivity) {
                    decreaseMinute();
                  }
                },
                child: Column(
                  children: [
                    const Instructions(),
                    Text(
                      '${_tempDateTime.hour < 10 ? '0${_tempDateTime.hour}' : _tempDateTime.hour}:${_tempDateTime.minute < 10 ? '0${_tempDateTime.minute}' : _tempDateTime.minute}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Container(
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
                            angleRadians: _now.second * radiansPerTick,
                          ),
                          DrawnHand(
                            color: Colors.black,
                            thickness: 4,
                            size: 0.7,
                            angleRadians: _tempDateTime.minute * radiansPerTick,
                          ),
                          DrawnHand(
                            color: Colors.black,
                            thickness: 8,
                            size: 0.4,
                            angleRadians: _tempDateTime.hour * radiansPerHour +
                                (_tempDateTime.minute / 60) * radiansPerHour,
                          ),
                        ],
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

class Instructions extends StatelessWidget {
  const Instructions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/swipe.png',
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  'Swipe up/down to change the minute',
                  style: CustomTextTheme.getTextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Swipe left/right to change the hour,',
                  style: CustomTextTheme.getTextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
