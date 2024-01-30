import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:orio_evry_template/util/helper_util.dart';
import '../model/job_description_fine_tune_form.dart';
import '../service/job_description_filter.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';
import '../util/dialog_util.dart';

class JobDescriptionNegativeSentencesFormScreen extends StatefulWidget {
  const JobDescriptionNegativeSentencesFormScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionNegativeSentencesFormScreenState();
}

class _JobDescriptionNegativeSentencesFormScreenState
    extends State<JobDescriptionNegativeSentencesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedNegativeSentences = [];
  final int _itemQuantityMax = 100;
  final String _title =
      "Si besoin sélectionnez les domaines qui ne correspondent pas à vos attentes:";
  final String _dialogError = "Le nombre d'items sélectionnés est incorrect.";

  List<String> _negativeSentences = [];

  final String _forwardScreenPath = RoutingUtil.jobDescriptionResultsListScreen;

  @override
  void initState() {
    _negativeSentences = JobDescriptionFormUtil.negativeSentences!;
    super.initState();
  }

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
                                itemCount: _negativeSentences.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        child: CheckboxListTile(
                                          enabled: _enabledItem(
                                              _negativeSentences
                                                  .elementAt(index)),
                                          activeColor: ColorUtil.primary,
                                          title: Text(_negativeSentences
                                              .elementAt(index)),
                                          value: _selectedNegativeSentences
                                              .contains(_negativeSentences
                                                  .elementAt(index)),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value != null && value) {
                                                _selectedNegativeSentences.add(
                                                    _negativeSentences
                                                        .elementAt(index));
                                              } else {
                                                _selectedNegativeSentences
                                                    .remove(_negativeSentences
                                                        .elementAt(index));
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
                                if (!_respectedItemsQuantity(
                                    _selectedNegativeSentences)) {
                                  DialogUtil.launchError(context, _dialogError);
                                } else {
                                  _fetchFilteredJobDescriptionList();
                                }
                              },
                              backgroundColor: ColorUtil.primary,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50.0)),
                        ])))));
  }

  bool _respectedItemsQuantity(List<String> items) {
    return items.length <= _itemQuantityMax;
  }

  bool _enabledItem(String item) {
    return !(_selectedNegativeSentences.length == _itemQuantityMax &&
        _selectedNegativeSentences.isNotEmpty &&
        !_selectedNegativeSentences.contains(item));
  }

  void _fetchFilteredJobDescriptionList(){
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    JobDescriptionFormUtil.jobDescriptions =
        jobDescriptionFilter.getFilteredJobDescriptionByNegativeSentence(
            JobDescriptionFormUtil.jobDescriptions!,
            _selectedNegativeSentences);
    JobDescriptionFormUtil.sectors = jobDescriptionFilter
        .getSectorForFilter(JobDescriptionFormUtil.jobDescriptions!);
    Navigator.pushNamed(context, RoutingUtil.jobDescriptionSectorFormScreen);

  }
}
