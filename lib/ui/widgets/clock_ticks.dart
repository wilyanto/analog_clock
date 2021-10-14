import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class ClockTicks extends StatelessWidget {
  const ClockTicks({
    Key? key,
    required this.unit,
  }) : super(key: key);

  final double unit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var i = 0; i < 12; i++)
          Center(
            child: Transform.rotate(
              angle: radians(0 + 360 / 12 * i),
              child: Transform.translate(
                offset: Offset(0, i % 3 == 0 ? -10 * unit : -10.2 * unit),
                child: Container(
                  color: Colors.black,
                  height: i % 3 == 0 ? 2.0 * unit : 1.6 * unit,
                  width: i % 3 == 0 ? 0.25 * unit : 0.175 * unit,
                ),
              ),
            ),
          )
      ],
    );
  }
}
