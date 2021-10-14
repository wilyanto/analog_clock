import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/ui/pages/app_main_page.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello! isolate=$isolateId function ='$printHello'");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const int helloAlarmId = 0;
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());

  await AndroidAlarmManager.periodic(
    const Duration(seconds: 10),
    // const Duration(minutes: 1),
    helloAlarmId,
    printHello,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppMainPage(),
    );
  }
}
