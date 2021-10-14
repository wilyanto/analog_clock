import 'package:flutter/material.dart';
import 'package:flutter_clock/utils/theme.dart';

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
