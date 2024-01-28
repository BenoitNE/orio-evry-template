import 'package:flutter/material.dart';

import '../util/font_util.dart';


class ButtonFormWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final Color backgroundColor;
  final Color? textColor;

  const ButtonFormWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: 60.0,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 18.0,
                fontFamily: FontUtil.barfiola),
          ),
        ));
  }
}
