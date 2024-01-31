import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orio_evry_template/service/file_converter.dart';

import '../model/job_description.dart';
import '../util/color_util.dart';
import '../widget/appbar_form_widget.dart';

class ExploreDataScreen extends StatefulWidget {
  const ExploreDataScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExploreDataScreenState();
}

class _ExploreDataScreenState extends State<ExploreDataScreen> {
  final FileConverter _fileConverter = FileConverter();
  List<JobDescription> _jobDescriptions = [];

  Future<void> _loadData() async {
    _jobDescriptions = await _fileConverter.convertFileToJobDescriptionList();
  }

  @override
  void initState() {
    _loadData().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarFormWidget(color: ColorUtil.secondaryBackground),
        body: SingleChildScrollView(
            child: Align(child: SizedBox(
                width: 550.0,
                child: _jobDescriptions.isNotEmpty
                    ? ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _jobDescriptions.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            const Text("\n"),
                            Text("Métier : ${_jobDescriptions[index].job}"),
                            Text(
                                "Secteurs : ${_jobDescriptions[index].sectors}"),
                            Text(
                                "Traits de personnalité : ${_jobDescriptions[index].personalityTraits}"),
                            Text(
                                "Matières scolaires : ${_jobDescriptions[index].schoolSubjects}"),
                            Text(
                                "Intérêts : ${_jobDescriptions[index].interests}"),
                            Text(
                                "Durée d'études : ${_jobDescriptions[index].studyDuration}"),
                            Text("Salaire : ${_jobDescriptions[index].salary}"),
                            Text(
                                "Environnement social : ${_jobDescriptions[index].socialEnvironment}"),
                            Text(
                                "Environnement physique : ${_jobDescriptions[index].physicalEnvironments}"),
                            Text(
                                "Description : ${_jobDescriptions[index].description}"),
                            Text("Etudes : ${_jobDescriptions[index].study}"),
                            Text(
                                "Score de l'utilisateur : ${_jobDescriptions[index].userScore}"),
                            Text("Etoiles : ${_jobDescriptions[index].star}"),
                            Text(
                                "Traits de personnalité pour l'algorithme : ${_jobDescriptions[index].personalityTraitsToSearch}"),
                            Text(
                                "Matières scolaires pour l'algorithme : ${_jobDescriptions[index].schoolSubjectsToSearch}"),
                            Text(
                                "Secteurs pour l'algorithme : ${_jobDescriptions[index].sectorsToSearch}"),
                            Text(
                                "Phrases négatives pour l'algorithme : ${_jobDescriptions[index].negativeSentence}"),
                            const Text("\n"),
                          ]);
                        })
                    : Container()))));
  }
}
