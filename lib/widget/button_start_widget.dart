import 'package:flutter/material.dart';

import '../util/color_util.dart';

class ButtonStartWidget extends StatelessWidget {
  final Function onPressed;

  const ButtonStartWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorUtil.primary,
      ),
      child: IconButton(
        onPressed: () => onPressed(),
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30.0),
      ),
    );
  }
}
