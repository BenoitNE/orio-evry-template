

import 'package:flutter/material.dart';
import 'package:orio_evry_template/service/file_converter.dart';
import 'package:orio_evry_template/service/job_description_filter.dart';
import '../model/job_description.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';
import '../util/dialog_util.dart';

class JobDescriptionSchoolSubjectFormScreen extends StatefulWidget {
  const JobDescriptionSchoolSubjectFormScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionSchoolSubjectFormScreenState();
}

class _JobDescriptionSchoolSubjectFormScreenState
    extends State<JobDescriptionSchoolSubjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _responses = [];
  final List<String> _selectedItems = [];
  final int _itemQuantityMax = 3;
  final int jobDescriptionQuantity = 30;
  final String _title =
      "Sélectionnez 3 matières qui vous semble la plus importantes pour votre future métier :";
  final String _dialogError = "Le nombre d'items sélectionnés est incorrect.";

  final Map<String, String> _mappingItems = {
    "Langue": "0",
    "Littérature": "1",
    "Sciences humaines et sociales": "2",
    "Matières scientifiques et développement": "3",
    "Arts": "4",
    "Culture": "5",
    "Santé": "6",
    "Bien-être": "7",
    "Activités physiques et sportives": "8",
    "Commerce": "9",
    "Gestion": "10",
    "Informatique": "11",
    "Technologie": "12",
    "Artisanat": "13",
    "Droit": "14",
    "Mathématique": "15"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.secondaryBackground,
        appBar: const AppBarFormWidget(color: ColorUtil.secondaryBackground),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _title,
                            style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontUtil.coolvetica),
                          ),
                          const SizedBox(height: 32.0),
                          Container(
                            padding: const EdgeInsets.all(25.0),
                            decoration: const BoxDecoration(
                                color: ColorUtil.primaryBackground,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _mappingItems.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        child: CheckboxListTile(
                                          enabled: _enabledItem(_mappingItems
                                              .keys
                                              .elementAt(index)),
                                          activeColor: ColorUtil.primary,
                                          title: Text(_mappingItems.keys
                                              .elementAt(index)),
                                          value: _selectedItems.contains(
                                              _mappingItems.keys
                                                  .elementAt(index)),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value != null && value) {
                                                _selectedItems.add(_mappingItems
                                                    .keys
                                                    .elementAt(index));
                                                _responses.add(_mappingItems[
                                                    _mappingItems.keys
                                                        .elementAt(index)]!);
                                              } else {
                                                _selectedItems.remove(
                                                    _mappingItems.keys
                                                        .elementAt(index));
                                                _responses.remove(_mappingItems[
                                                    _mappingItems.keys
                                                        .elementAt(index)]!);
                                              }
                                            });
                                          },
                                        ),
                                      ));
                                }),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50.0)),
                          Center(
                            child: ButtonFormWidget(
                              text: "Suivant",
                              width: 330.0,
                              onPressed: () {
                                if (!_respectedItemsQuantity(_selectedItems)) {
                                  DialogUtil.launchError(context, _dialogError);
                                } else {
                                  _responses;
                                  _fetchNegativeSentences();
                                }
                              },
                              backgroundColor: ColorUtil.primary,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50.0)),
                        ])))));
  }

  bool _respectedItemsQuantity(List<String> items) {
    return items.length <= _itemQuantityMax && items.isNotEmpty;
  }

  bool _enabledItem(String item) {
    return !(_selectedItems.length == _itemQuantityMax &&
        _selectedItems.isNotEmpty &&
        !_selectedItems.contains(item));
  }

  Future<void> _fetchNegativeSentences() async {
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    FileConverter fileConverter = FileConverter();
    List<JobDescription> jobDescriptions =
        await fileConverter.convertFileToJobDescriptionList();

    print("00000${jobDescriptions.length}");

    List<JobDescription> filteredJobDescriptions =
        jobDescriptionFilter.getFilteredJobDescriptionByStudyDuration(
            jobDescriptions, JobDescriptionFormUtil.studyDurations!);
    print("00000${filteredJobDescriptions.length}");

    jobDescriptionFilter.getUpdatedJobDescriptionBySectorFamily(
        filteredJobDescriptions, JobDescriptionFormUtil.sectorFamilies!);
    jobDescriptionFilter.getUpdatedJobDescriptionByPersonalityTraitsFamily(
        filteredJobDescriptions, JobDescriptionFormUtil.personalityTraitFamilies!);

    print("111111${filteredJobDescriptions.length}");

    jobDescriptionFilter
        .getUpdatedJobDescriptionBySchoolSubjectsFamily(
            jobDescriptions, _responses)
        .sort((a, b) => b.userScore.compareTo(a.userScore));

    print("2222222${filteredJobDescriptions.length}");

    for (int i = 0; i < jobDescriptionQuantity; i++) {
      JobDescriptionFormUtil.jobDescriptions!.add(filteredJobDescriptions[i]);
    }

    JobDescriptionFormUtil.negativeSentences = jobDescriptionFilter
        .getNegativeSentenceForFilter(JobDescriptionFormUtil.jobDescriptions!);

    if (JobDescriptionFormUtil.negativeSentences!.isEmpty) {
      JobDescriptionFormUtil.jobDescriptions =
          jobDescriptionFilter.getFilteredJobDescriptionByNegativeSentence(
              JobDescriptionFormUtil.jobDescriptions!,
              JobDescriptionFormUtil.negativeSentences!);
      JobDescriptionFormUtil.sectors = jobDescriptionFilter
          .getSectorForFilter(JobDescriptionFormUtil.jobDescriptions!);
      Navigator.pushNamed(context, RoutingUtil.jobDescriptionSectorFormScreen);
    } else {
      Navigator.pushNamed(
          context, RoutingUtil.jobDescriptionNegativeSentencesFormScreen);
    }
  }
}
