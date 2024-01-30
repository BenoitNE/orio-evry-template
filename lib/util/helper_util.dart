import 'package:orio_evry_template/util/job_description_form_util.dart';

import '../model/job_description.dart';

class HelperUtil{
  static void printForm(List<JobDescription> jobDescriptions){
    print("*****************HELPER*******************");
    print("Study duration : ${JobDescriptionFormUtil.studyDurations}");
    print("Sector families : ${JobDescriptionFormUtil.sectorFamilies}");
    print("Personality traits : ${JobDescriptionFormUtil.personalityTraitFamilies}");
    print("Negative sentences : ${JobDescriptionFormUtil.negativeSentences}");
    print("Sectors : ${JobDescriptionFormUtil.sectors}");
    print("Nombre de job : ${jobDescriptions.length}");
    for(int i = 0; i < 10; i++){
      print("${jobDescriptions[i].job} + | Score: ${jobDescriptions[i].userScore}");
    }
    print("******************************************");
  }
}


