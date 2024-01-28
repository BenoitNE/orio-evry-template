import 'package:flutter/material.dart';
import '../util/color_util.dart';
import '../util/dialog_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';


class JobDescriptionStudyDurationsFormScreen extends StatefulWidget {
  const JobDescriptionStudyDurationsFormScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionStudyDurationsFormScreenState();
}

class _JobDescriptionStudyDurationsFormScreenState
    extends State<JobDescriptionStudyDurationsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _responses = [];
  final List<String> _selectedItems = [];
  final int _itemQuantityMax = 3;
  final String _title =
      "Quelle durée d'études envisageriez-vous ? Sélectionnez-en au mois une.";
  final String _dialogError = "Le nombre d'items sélectionnés est incorrect.";

  final Map<String, String> _mappingItems = {
    "Courte (Bac, inférieur au Bac ou sans diplôme)": "0",
    "Moyenne (Bac +2, Bac +3)": "1",
    "Longue (Bac +5 et supérieur)": "2"
  };

  final String _forwardScreenPath =
      RoutingUtil.jobDescriptionSectorFamiliesFormScreen;


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
                                  JobDescriptionFormUtil.studyDurations =
                                      _responses;
                                  Navigator.pushNamed(
                                      context, _forwardScreenPath);
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
}
