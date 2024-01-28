import 'package:flutter/cupertino.dart';

import '../screen/home_screen.dart';
import '../screen/job_description_display_screen.dart';
import '../screen/job_description_negative_sentences_form_screen.dart';
import '../screen/job_description_personality_trait_families_form_screen.dart';
import '../screen/job_description_school_subject_form_screen.dart';
import '../screen/job_description_sector_families_form_screen.dart';
import '../screen/job_description_sector_form_screen.dart';
import '../screen/job_description_study_durations_form_Screen.dart';
import '../screen/job_descriptions_results_list_screen.dart';

class RoutingUtil {
  static const String homeScreen = '/home';
  static const String jobDescriptionStudyDurationFormScreen =
      '/job-description-study-duration-form';
  static const String jobDescriptionSectorFamiliesFormScreen =
      '/job-description-sector-families-form';
  static const String jobDescriptionPersonalityTraitFamiliesFormScreen =
      '/job-description-personality-trait-families-form';
  static const String jobDescriptionSchoolObjectFamiliesFormScreen =
      '/job-description-school-object-families-form';
  static const String jobDescriptionNegativeSentencesFormScreen =
      '/job-description-negative-sentences-form';
  static const String jobDescriptionResultsListScreen =
      '/job-description-results-list';
  static const String jobDescriptionDisplayScreen = '/job-description-display';
  static const String jobDescriptionSaveToMail = "/job-description-save-to-mail";
  static const String jobDescriptionSectorFormScreen = "/job-description-sector-form";

  Map<String, Widget Function(BuildContext)> getRoutesApp(
      BuildContext context) =>
      {
        homeScreen: (context) => const HomeScreen(),
        jobDescriptionStudyDurationFormScreen: (context) =>
        const JobDescriptionStudyDurationsFormScreen(),
        jobDescriptionSectorFamiliesFormScreen: (context) =>
        const JobDescriptionSectorFamiliesFormScreen(),
        jobDescriptionPersonalityTraitFamiliesFormScreen: (context) =>
        const JobDescriptionPersonalityTraitFamiliesFormScreen(),
        jobDescriptionSchoolObjectFamiliesFormScreen: (context) =>
        const JobDescriptionSchoolSubjectFormScreen(),
        jobDescriptionNegativeSentencesFormScreen: (context) =>
        const JobDescriptionNegativeSentencesFormScreen(),
        jobDescriptionResultsListScreen: (context) =>
        const JobDescriptionResultsListScreen(),
        jobDescriptionDisplayScreen: (context) => const JobDescriptionDisplayScreen(),
        jobDescriptionSectorFormScreen: (context) => const JobDescriptionSectorFormScreen()
      };
}
