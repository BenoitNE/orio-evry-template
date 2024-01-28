import 'package:flutter/material.dart';
import 'package:orio_evry_template/screen/job_description_study_durations_form_Screen.dart';

import '../util/asset_path_util.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/routing_util.dart';
import '../widget/button_start_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  final String _version = "Orio Evry-Courcouronnes template 0.1.0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.primaryBackground,
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 133.0)),
              Image.asset(
                AssetPathUtil.avatarOrioIntro,
                width: 350.0,
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              const Text(
                'Trouvez la voie qui vous correspond avec Orio',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorUtil.primary,
                    fontFamily: FontUtil.coolvetica,
                    fontSize: 33.0,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 22.0)),
              const Text(
                'Remplissez le formulaire suivant et découvrez\ndes métiers qui vous conviennent.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 85.0)),
              ButtonStartWidget(onPressed: () {
                Navigator.pushNamed(
                    context, RoutingUtil.jobDescriptionStudyDurationFormScreen);
              }),
              const Padding(padding: EdgeInsets.only(top: 75.0)),
              Text(_version,
                  style: const TextStyle(color: ColorUtil.secondaryText)),
            ],
          ),
        )));
  }
}
