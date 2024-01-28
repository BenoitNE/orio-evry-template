import 'dart:io';
import 'dart:convert';

import '../model/job_description.dart';
import '../util/job_description_item_util.dart';

class FileConverter {
  static const String filePath = 'assets/FINAL_fiche_metier.txt';

  List<JobDescription> convertFileToJobDescriptionList() {
    List<JobDescription> jobDescriptionEntities = [];
    List<Map<String, String>>? jobDescriptionMapList;
    try {
      jobDescriptionMapList = getJobDescriptionMapList();
    } catch (e) {
      print(e);
    }

    if (jobDescriptionMapList != null) {
      for (var i = 0; i < jobDescriptionMapList.length; i++) {
        JobDescription jobDescription = JobDescription();
        jobDescription.job = jobDescriptionMapList[i][JobDescriptionItemUtil.JOB_ITEM];
        jobDescription.sectors = jobDescriptionMapList[i][JobDescriptionItemUtil.SECTOR_ITEM]?.toLowerCase().trim().split(" et ") ?? [];
        jobDescription.personalityTraits = jobDescriptionMapList[i][JobDescriptionItemUtil.PERSONALITY_TRAITS_ITEM]?.split(", ") ?? [];
        jobDescription.schoolSubjects = jobDescriptionMapList[i][JobDescriptionItemUtil.SCHOOL_SUBJECTS_ITEM]?.split(", ") ?? [];
        jobDescription.interests = jobDescriptionMapList[i][JobDescriptionItemUtil.INTERESTS_ITEM]?.split(", ") ?? [];
        jobDescription.studyDuration = jobDescriptionMapList[i][JobDescriptionItemUtil.STUDY_DURATION_ITEM]?.toLowerCase() ?? '';
        jobDescription.socialEnvironment = jobDescriptionMapList[i][JobDescriptionItemUtil.SOCIAL_ENVIRONMENT_ITEM];
        jobDescription.physicalEnvironments = jobDescriptionMapList[i][JobDescriptionItemUtil.PHYSICAL_ENVIRONMENT_ITEM]?.split(", ") ?? [];
        jobDescription.salary = jobDescriptionMapList[i][JobDescriptionItemUtil.SALARY_ITEM] ?? '';
        jobDescription.description = jobDescriptionMapList[i][JobDescriptionItemUtil.DESCRIPTION_ITEM] ?? '';
        jobDescription.personalityTraitsToSearch = jobDescriptionMapList[i][JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ITEM]?.toLowerCase().split(", ") ?? [];
        jobDescription.schoolSubjectsToSearch = jobDescriptionMapList[i][JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ITEM]?.toLowerCase().split(", ") ?? [];
        jobDescription.study = jobDescriptionMapList[i][JobDescriptionItemUtil.STUDY_ITEM];
        jobDescription.userScore = 0;
        jobDescription.sectorsToSearch = jobDescriptionMapList[i][JobDescriptionItemUtil.SECTOR_FAMILY_ITEM];
        jobDescription.negativeSentence = jobDescriptionMapList[i][JobDescriptionItemUtil.NEGATIVE_SENTENCE_ITEM];

        jobDescriptionEntities.add(jobDescription);
      }
    }
    return jobDescriptionEntities;
  }

  List<Map<String, String>> getJobDescriptionMapList() {
    String fileContent = File(filePath).readAsStringSync();
    List<Map<String, String>> jobDescriptionMapList = initJobDescriptionMapList();
    Map<String, List<String>> jobDescriptionMap = buildJobDescriptionMap(fileContent);
    List<String> items = JobDescriptionItemUtil.JOB_DESCRIPTIONS_ITEMS;

    for (var item in items) {
      for (var i = 0; i < JobDescriptionItemUtil.JOB_QUANTITY; i++) {
        jobDescriptionMapList[i][item] = jobDescriptionMap[item]![i];
      }
    }


    return jobDescriptionMapList;
  }

  List<Map<String, String>> initJobDescriptionMapList() {
    List<Map<String, String>> jobDescriptionMapList = List.generate(JobDescriptionItemUtil.JOB_QUANTITY, (index) => {});
    return jobDescriptionMapList;
  }

  Map<String, List<String>> buildJobDescriptionMap(String fileContent) {
    Map<String, List<String>> jobDescriptionMap = {};
    List<String> lines = LineSplitter.split(fileContent).toList();

    for (var i = 0; i < JobDescriptionItemUtil.JOB_DESCRIPTIONS_ITEMS.length; i++) {
      jobDescriptionMap[JobDescriptionItemUtil.JOB_DESCRIPTIONS_ITEMS[i]] = [];
    }

    for (var line in lines) {
      for (var item in JobDescriptionItemUtil.JOB_DESCRIPTIONS_ITEMS) {
        if (line.startsWith(item)) {
          String content = line.substring(item.length + 1);
          jobDescriptionMap[item]!.add(content);
        }
      }
    }
    return jobDescriptionMap;
  }

}
