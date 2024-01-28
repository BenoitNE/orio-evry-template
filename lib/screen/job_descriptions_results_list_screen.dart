import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../model/job_description.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/gesture_detector_select_job_description_widget.dart';

class JobDescriptionResultsListScreen extends StatefulWidget {
  const JobDescriptionResultsListScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionResultsListScreenState();
}

class _JobDescriptionResultsListScreenState
    extends State<JobDescriptionResultsListScreen> {
  final List<JobDescription> _jobDescriptions =
      JobDescriptionFormUtil.jobDescriptions!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.secondaryBackground,
        appBar: const AppBarFormWidget(color: ColorUtil.secondaryBackground),
        body: SingleChildScrollView(
            child: Column(children: [
          const Text(
            "Résultats",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: FontUtil.coolvetica),
          ),
          const SizedBox(height: 32.0),
          Center(
              child: SizedBox(
                  width: 550.0,
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (_jobDescriptions.length / 3).ceil(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, rowIndex) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (colIndex) {
                                final itemIndex = rowIndex * 3 + colIndex;
                                if (itemIndex < _jobDescriptions.length) {
                                  return GestureDetectorSelectJobDescriptionWidget(
                                      jobDescription:
                                          _jobDescriptions[itemIndex]);
                                } else {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    width: 145.0,
                                    height: 160.0,
                                    color: Colors.white,
                                  );
                                }
                              })));
                    },
                  ))),
          const SizedBox(height: 45.0),
        ])));
  }
}
