import 'package:flutter/material.dart';

import '../model/job_description.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../util/sector_image_util.dart';


class GestureDetectorSelectJobDescriptionWidget extends StatelessWidget {
  final JobDescription jobDescription;

  const GestureDetectorSelectJobDescriptionWidget(
      {Key? key, required this.jobDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          JobDescriptionFormUtil.selectedJobDescription = jobDescription;
          Navigator.pushNamed(context, RoutingUtil.jobDescriptionDisplayScreen);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10.0),
          width: 145.0,
          height: 160.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      color: ColorUtil.secondaryBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Image.asset(
                      SectorImageUtil.getPath(jobDescription.sectorsToSearch!),
                      color: ColorUtil.primary,
                    )),
                  ),
                  const SizedBox(width: 22.0),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(jobDescription.star, (index) {
                        return const Icon(
                          Icons.star,
                          size: 12.0,
                          color: ColorUtil.secondaryText,
                        );
                      }))
                ],
              ),
              const SizedBox(height: 9.0),
              Text(
                jobDescription.job!,
                style: const TextStyle(
                    fontFamily: FontUtil.barfiola,
                    fontWeight: FontWeight.bold,
                    color: ColorUtil.primary,
                    fontSize: 11.0),
              ),
              const SizedBox(height: 9.0),
              Text(
                jobDescription.sectors
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style: const TextStyle(
                    fontFamily: FontUtil.barfiola,
                    color: ColorUtil.secondaryText,
                    fontSize: 10.0),
              ),
              const SizedBox(height: 12.0),
              const Center(
                  child: Icon(Icons.arrow_drop_down, color: ColorUtil.primary))
            ],
          ),
        ));
  }
}
