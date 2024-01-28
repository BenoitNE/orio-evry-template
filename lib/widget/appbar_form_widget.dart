import 'package:flutter/material.dart';
import 'package:orio_evry_template/screen/home_screen.dart';

import '../util/color_util.dart';
import '../util/font_util.dart';

class AppBarFormWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color color;

  const AppBarFormWidget({super.key, required this.color});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: const Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Text("Home",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: FontUtil.barfiola,
                          color: ColorUtil.primary,
                          fontWeight: FontWeight.bold))))
        ],
        elevation: 0,
        backgroundColor: color,
        leading: Row(children: [
          const Padding(padding: EdgeInsets.only(left: 22.0)),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorUtil.primary,
            ),
          )
        ]));
  }
}
