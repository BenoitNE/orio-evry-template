import 'package:flutter/material.dart';
import 'package:orio_evry_template/service/job_description_filter.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';
import '../util/dialog_util.dart';

class JobDescriptionSectorFormScreen extends StatefulWidget {
  const JobDescriptionSectorFormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JobDescriptionSectorFormScreenState();
}

class _JobDescriptionSectorFormScreenState
    extends State<JobDescriptionSectorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedSectors = [];
  late int _itemQuantityMax;
  final String _title =
      "Si besoin sélectionnez les environnements ou secteurs dans lesquels vous ne souhaiteriez pas travailler:";
  final String _dialogError =
      "Vous ne pouvez pas sélectionner l'ensemble des items.";

  List<String> _sectors = [];

  final String _forwardScreenPath = RoutingUtil.jobDescriptionResultsListScreen;

  @override
  void initState() {
    _sectors = JobDescriptionFormUtil.jobDescriptionFineTuneForm!.contents!;
    _itemQuantityMax = _sectors.length;
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
                                itemCount: _sectors.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: SizedBox(
                                        height: 60.0,
                                        child: CheckboxListTile(
                                          enabled: _enabledItem(
                                              _sectors.elementAt(index)),
                                          activeColor: ColorUtil.primary,
                                          title:
                                              Text(_sectors.elementAt(index)),
                                          value: _selectedSectors.contains(
                                              _sectors.elementAt(index)),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value != null && value) {
                                                _selectedSectors.add(
                                                    _sectors.elementAt(index));
                                              } else {
                                                _selectedSectors.remove(
                                                    _sectors.elementAt(index));
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
                                    _selectedSectors)) {
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
    return items.length < _itemQuantityMax;
  }

  bool _enabledItem(String item) {
    return !(_selectedSectors.length == _itemQuantityMax &&
        _selectedSectors.isNotEmpty &&
        !_selectedSectors.contains(item));
  }

  void _fetchFilteredJobDescriptionList() {
    JobDescriptionFilter jobDescriptionFilter = JobDescriptionFilter();
    JobDescriptionFormUtil.jobDescriptions =
        jobDescriptionFilter.getFilteredJobDescriptionBySector(
            JobDescriptionFormUtil.jobDescriptions!,
            _selectedSectors);
    Navigator.pushNamed(context, _forwardScreenPath);
  }
}
