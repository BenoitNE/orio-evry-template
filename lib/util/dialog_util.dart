import 'package:flutter/material.dart';


import 'asset_path_util.dart';
import 'color_util.dart';

class DialogUtil {
  static void launchError(BuildContext context, String message) =>
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: SizedBox(
                  height: 100,
                  child: Image.asset(AssetPathUtil.errorDrawing),
                ),
                content: SizedBox(
                    width: 66,
                    child: Text(message,
                        style: const TextStyle(color: ColorUtil.primary))),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Retour',
                      style: TextStyle(color: ColorUtil.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ));
}
