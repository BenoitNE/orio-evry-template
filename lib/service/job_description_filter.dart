import '../model/job_description.dart';
import '../util/job_description_score_util.dart';

class JobDescriptionFilter {
  List<JobDescription> getFilteredJobDescriptionByStudyDuration(
      List<JobDescription> jobDescriptions, List<String> studyDurations) {
    List<JobDescription> updatedJobDescriptions = [];

    for (String studyDuration in studyDurations) {
      for (var jobDescription in jobDescriptions) {
        if (jobDescription.studyDuration!.contains(studyDuration)) {
          updatedJobDescriptions.add(jobDescription);
        }
      }
    }

    updatedJobDescriptions.sort((a, b) => b.userScore!.compareTo(a.userScore!));

    return updatedJobDescriptions;
  }

  List<JobDescription> getUpdatedJobDescriptionByPersonalityTraitsFamily(
      List<JobDescription> jobDescriptions,
      List<String> selectedPersonalityTraitsToSearch) {
    for (var jobDescription in jobDescriptions) {
      int score = jobDescription.userScore!;
      for (var i = 0; i < selectedPersonalityTraitsToSearch.length; i++) {
        if (jobDescription.personalityTraitsToSearch!
            .contains(selectedPersonalityTraitsToSearch[i])) {
          score += JobDescriptionScoreUtil.PERSONALITY_TRAITS_FAMILY_SCORE;
        }
      }
      jobDescription.userScore = score;
    }

    jobDescriptions.sort((a, b) => b.userScore!.compareTo(a.userScore!));

    return jobDescriptions;
  }

  List<JobDescription> getUpdatedJobDescriptionBySchoolSubjectsFamily(
      List<JobDescription> jobDescriptions,
      List<String> selectedSchoolSubjectsToSearch) {
    for (var jobDescription in jobDescriptions) {
      int score = jobDescription.userScore!;
      for (var i = 0; i < selectedSchoolSubjectsToSearch.length; i++) {
        if (jobDescription.schoolSubjectsToSearch!
            .contains(selectedSchoolSubjectsToSearch[i])) {
          score += JobDescriptionScoreUtil.SCHOOL_SUBJECTS_FAMILY_SCORE;
        }
      }
      jobDescription.userScore = score;
    }

    jobDescriptions.sort((a, b) => b.userScore!.compareTo(a.userScore!));

    return jobDescriptions;
  }

  List<JobDescription> getUpdatedJobDescriptionBySectorFamily(
      List<JobDescription> jobDescriptions,
      List<String> selectedSectorsToSearch) {
    for (var jobDescription in jobDescriptions) {
      int score = jobDescription.userScore!;
      for (var i = 0; i < selectedSectorsToSearch.length; i++) {
        if (jobDescription.sectorsToSearch!
            .contains(selectedSectorsToSearch[i])) {
          score += JobDescriptionScoreUtil.SECTOR_FAMILY_SCORE;
        }
      }
      jobDescription.userScore = score;
    }

    jobDescriptions.sort((a, b) => b.userScore!.compareTo(a.userScore!));

    return jobDescriptions;
  }

  List<JobDescription> getFilteredJobDescriptionByNegativeSentence(
      List<JobDescription> jobDescriptions, List<String> negativeSentences) {
    List<JobDescription> results = [];

    for (var jobDescription in jobDescriptions) {
      if (!negativeSentences.contains(jobDescription.negativeSentence)) {
        results.add(jobDescription);
      }
    }

    results.sort((b, a) => a.userScore!.compareTo(b.userScore!));

    return results;
  }

  List<String> getNegativeSentenceForFilter(
      List<JobDescription> jobDescriptions) {
    List<String> sectors = [];
    Map<String, List<String>> sectorSentenceMap = {};
    List<String> results = [];

    for (var jobDescription in jobDescriptions) {
      sectors.add(jobDescription.sectorsToSearch!);
    }

    for (var sector in sectors) {
      sectorSentenceMap[sector] = [];
    }

    for (var jobDescription in jobDescriptions) {
      sectorSentenceMap[jobDescription.sectorsToSearch!]!
          .add(jobDescription.negativeSentence!);
    }

    for (var sector in sectors) {
      if (!(sectorSentenceMap[sector]!.length > 1)) {
        results.add(sectorSentenceMap[sector]![0]);
      }
    }

    return results;
  }

  void setJobDescriptionStar(List<JobDescription> jobDescriptions) {
    var stars = [5, 4, 3, 2, 1];
    List<int> topScores = [];

    for (var jobDescription in jobDescriptions) {
      if (!topScores.contains(jobDescription.userScore)) {
        topScores.add(jobDescription.userScore!);
      }
    }

    topScores.sort((b, a) => a.compareTo(b));

    Map<int, int> scoreStarMap = {};

    for (var i = 0; i < stars.length; i++) {
      if (i < topScores.length) {
        scoreStarMap[topScores[i]] = stars[i];
      }
    }

    for (var jobDescription in jobDescriptions) {
      if (scoreStarMap.containsKey(jobDescription.userScore)) {
        jobDescription.star = scoreStarMap[jobDescription.userScore]!;
      }
    }
  }
}
