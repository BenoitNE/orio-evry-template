
import '../model/job_description.dart';


class JobDescriptionFormUtil {
  static List<String>? studyDurations;
  static List<String>? sectorFamilies;
  static List<String>? personalityTraitFamilies;
  static List<JobDescription> displayedJobDescriptions = [];
  static JobDescription? selectedJobDescription;
  static List<String>? negativeSentences;
  static List<String>? sectors;

  static List<JobDescription> jobDescriptionsFirstFiltered = [];
  static List<JobDescription> jobDescriptionsFilteredByNegativeSentences = [];

}
