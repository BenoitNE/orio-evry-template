import 'package:flutter_test/flutter_test.dart';
import 'package:orio_evry_template/model/job_description.dart';
import 'package:orio_evry_template/service/file_converter.dart';
import 'package:orio_evry_template/service/job_description_filter.dart';
import 'package:orio_evry_template/util/job_description_item_util.dart';
import 'package:orio_evry_template/util/job_description_score_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('studyDurationFilter_OneSelectedItem', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getFilteredJobDescriptionByStudyDuration(
            jobDescriptions, [JobDescriptionItemUtil.STUDY_DURATION_LONG]);

    expect(filteredJobDescriptions.length, equals(122));
  });

  test('studyDurationFilter_TwoSelectedItem', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getFilteredJobDescriptionByStudyDuration(jobDescriptions, [
      JobDescriptionItemUtil.STUDY_DURATION_LONG,
      JobDescriptionItemUtil.STUDY_DURATION_SHORT
    ]);

    expect(filteredJobDescriptions.length, equals(223));
  });

  test('PersonalityTraitsFamilySearchFilter', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionByPersonalityTraitsFamily(jobDescriptions, [
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[7],
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[11],
    ]);

    expect(filteredJobDescriptions[558].userScore, 0);

    expect(filteredJobDescriptions[0].userScore,
        equals(JobDescriptionScoreUtil.PERSONALITY_TRAITS_FAMILY_SCORE * 3));
  });

  test('SchoolSubjectsSearchFilter', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionBySchoolSubjectsFamily(jobDescriptions, [
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[6],
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[9],
    ]);

    expect(filteredJobDescriptions[558].userScore, 0);

    expect(filteredJobDescriptions[0].userScore,
        equals(JobDescriptionScoreUtil.SCHOOL_SUBJECTS_FAMILY_SCORE * 2));
  });

  test('SectorSearchFilter', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionBySectorFamily(jobDescriptions, [
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[7],
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[11],
    ]);

    expect(filteredJobDescriptions[558].userScore, 0);

    expect(filteredJobDescriptions[0].userScore,
        equals(JobDescriptionScoreUtil.SECTOR_FAMILY_SCORE));
  });

  test('getNegativeSentenceForFilter', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();
    List<JobDescription> selectedJobDescriptions = [];
    int negativeSentenceQuantity = 8;

    for (int i = 0; i < 20; i++) {
      selectedJobDescriptions.add(jobDescriptions[i]);
    }

    List<String> negativesSentences = jobDescriptionFilter
        .getNegativeSentenceForFilter(selectedJobDescriptions);
    expect(negativesSentences.length, equals(negativeSentenceQuantity));
  });

  test('filteredJobDescriptionByNegativeSentence', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();

    List<String> negativeSentences = [
      "je ne suis pas attiré par le secteur qui concerne l'assistance et les soins aux personnes dans le besoin.",
      "je ne suis pas attiré par les interactions humaines et les relations communautaires.",
      "je ne suis pas attiré par le secteur financier."
    ];

    int jobDescriptionQuantity = 556;

    List<JobDescription> filteredJobDescriptionList =
        jobDescriptionFilter.getFilteredJobDescriptionByNegativeSentence(
            jobDescriptions, negativeSentences);

    expect(filteredJobDescriptionList.length, equals(jobDescriptionQuantity));
  });

  test('checkSetJobDescriptionStar', () {
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions = [];

    for (int i = 0; i < 10; i++) {
      JobDescription jobDescription = JobDescription();
      jobDescriptions.add(jobDescription);
    }

    jobDescriptions[0].userScore = 3;
    jobDescriptions[1].userScore = 2;
    jobDescriptions[2].userScore = 0;
    jobDescriptions[3].userScore = 8;
    jobDescriptions[4].userScore = 11;
    jobDescriptions[5].userScore = 8;
    jobDescriptions[6].userScore = 11;
    jobDescriptions[7].userScore = 6;
    jobDescriptions[8].userScore = 1;
    jobDescriptions[9].userScore = 3;

    int expectedResponse_00 = 2;
    int expectedResponse_01 = 1;
    int expectedResponse_02 = 0;
    int expectedResponse_03 = 4;
    int expectedResponse_04 = 5;
    int expectedResponse_05 = 4;
    int expectedResponse_06 = 5;
    int expectedResponse_07 = 3;
    int expectedResponse_08 = 0;
    int expectedResponse_09 = 2;

    jobDescriptionFilter.setJobDescriptionStar(jobDescriptions);

    expect(jobDescriptions[0].star, equals(expectedResponse_00));
    expect(jobDescriptions[1].star, equals(expectedResponse_01));
    expect(jobDescriptions[2].star, equals(expectedResponse_02));
    expect(jobDescriptions[3].star, equals(expectedResponse_03));
    expect(jobDescriptions[4].star, equals(expectedResponse_04));
    expect(jobDescriptions[5].star, equals(expectedResponse_05));
    expect(jobDescriptions[6].star, equals(expectedResponse_06));
    expect(jobDescriptions[7].star, equals(expectedResponse_07));
    expect(jobDescriptions[8].star, equals(expectedResponse_08));
    expect(jobDescriptions[9].star, equals(expectedResponse_09));


  });

  test('checkSetJobDescriptionStar_littleSelection', () {
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions = [];

    for (int i = 0; i < 10; i++) {
      JobDescription jobDescription = JobDescription();
      jobDescriptions.add(jobDescription);
    }

    jobDescriptions[0].userScore = 3;
    jobDescriptions[1].userScore = 3;
    jobDescriptions[2].userScore = 0;
    jobDescriptions[3].userScore = 1;
    jobDescriptions[4].userScore = 0;
    jobDescriptions[5].userScore = 0;
    jobDescriptions[6].userScore = 0;
    jobDescriptions[7].userScore = 3;
    jobDescriptions[8].userScore = 1;
    jobDescriptions[9].userScore = 0;

    int expectedResponse_00 = 5;
    int expectedResponse_01 = 5;
    int expectedResponse_02 = 3;
    int expectedResponse_03 = 4;
    int expectedResponse_04 = 3;
    int expectedResponse_05 = 3;
    int expectedResponse_06 = 3;
    int expectedResponse_07 = 5;
    int expectedResponse_08 = 4;
    int expectedResponse_09 = 3;

    jobDescriptionFilter.setJobDescriptionStar(jobDescriptions);

    expect(jobDescriptions[0].star, equals(expectedResponse_00));
    expect(jobDescriptions[1].star, equals(expectedResponse_01));
    expect(jobDescriptions[2].star, equals(expectedResponse_02));
    expect(jobDescriptions[3].star, equals(expectedResponse_03));
    expect(jobDescriptions[4].star, equals(expectedResponse_04));
    expect(jobDescriptions[5].star, equals(expectedResponse_05));
    expect(jobDescriptions[6].star, equals(expectedResponse_06));
    expect(jobDescriptions[7].star, equals(expectedResponse_07));
    expect(jobDescriptions[8].star, equals(expectedResponse_08));
    expect(jobDescriptions[9].star, equals(expectedResponse_09));
  });

  test('AllFilter', () async {
    FileConverter fileConverter = FileConverter();
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();

    List<JobDescription> filteredJobDescriptions = jobDescriptionFilter
        .getFilteredJobDescriptionByStudyDuration(
        jobDescriptions, [JobDescriptionItemUtil.STUDY_DURATION_LONG]);

    filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionByPersonalityTraitsFamily(filteredJobDescriptions, [
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[7],
      JobDescriptionItemUtil.PERSONALITY_TRAITS_FAMILY_ELEMENTS[11],
    ]);

    filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionBySchoolSubjectsFamily(filteredJobDescriptions, [
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[6],
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.SCHOOL_SUBJECTS_FAMILY_ELEMENTS[9],
    ]);

    filteredJobDescriptions = jobDescriptionFilter
        .getUpdatedJobDescriptionBySectorFamily(filteredJobDescriptions, [
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[4],
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[7],
      JobDescriptionItemUtil.SECTOR_FAMILY_ELEMENTS[11],
    ]);

    for(JobDescription jobDescription in filteredJobDescriptions){
      print("${jobDescription.job} | score: ${jobDescription.userScore}}");
    }

    expect(filteredJobDescriptions.length, equals(122));
  });
}
