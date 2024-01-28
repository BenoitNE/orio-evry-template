import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/job_description.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/sector_image_util.dart';
import '../widget/appbar_form_widget.dart';

class JobDescriptionDisplayScreen extends StatefulWidget {
  const JobDescriptionDisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JobDescriptionDisplayScreenState();
}

class _JobDescriptionDisplayScreenState
    extends State<JobDescriptionDisplayScreen> {
  final JobDescription jobDescription =
      JobDescriptionFormUtil.selectedJobDescription!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarFormWidget(color: ColorUtil.secondary),
        backgroundColor: ColorUtil.secondaryBackground,
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: ColorUtil.secondaryBackground,
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobDescription.job!,
                style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Secteur",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: ColorUtil.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Image.asset(
                          SectorImageUtil.getPath(jobDescription.sectorsToSearch!),
                      color: Colors.white,
                    )),
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    jobDescription!.sectors
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: FontUtil.coolvetica,
                        color: ColorUtil.primary),
                  ),
                ],
              ),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 75.0, right: 18.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Durée d'études",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.studyDuration
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Matières scolaires",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.schoolSubjects
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Etudes",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.study
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Traits de personnalités",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.personalityTraits
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Centres d'intérêts",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.interests
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Salaire",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.salary
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Environnement de travail",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.physicalEnvironments
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 0.4,
                color: ColorUtil.secondaryText,
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              const SizedBox(height: 32.0),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText),
              ),
              const SizedBox(height: 12.0),
              Text(
                jobDescription!.description
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: FontUtil.coolvetica,
                    color: ColorUtil.primary),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        )));
  }
}
