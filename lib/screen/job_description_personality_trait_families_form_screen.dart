import 'package:flutter/material.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';
import '../util/dialog_util.dart';


class JobDescriptionPersonalityTraitFamiliesFormScreen extends StatefulWidget {
  const JobDescriptionPersonalityTraitFamiliesFormScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionPersonalityTraitFamiliesFormScreenState();
}

class _JobDescriptionPersonalityTraitFamiliesFormScreenState
    extends State<JobDescriptionPersonalityTraitFamiliesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _responses = [];
  final List<String> _selectedItems = [];
  final int _itemQuantityMax = 3;
  final String _title =
      "Parmi les phrases ci-dessous, veuillez choisir une à trois phrases qui se rapproche le plus de votre personnalité :";
  final String _dialogError = "Le nombre d'items sélectionnés est incorrect.";

  final Map<String, String> _mappingItems = {
    "Je m'adapte facilement à de nouvelles situations, en apprenant ou en changeant rapidement d'environnement.":
    "0",
    "Je prends du recul afin d'évaluer la meilleure manière de gérer une situation complexe.":
    "1",
    "Je m'exprime à travers des formes d'expression personnelle, me permettant d’explorer mon imagination.":
    "2",
    "J'apprécie d'aider mes voisins à décharger leur camion de déménagement, même si cela signifie porter des objets lourds.":
    "3",
    "Je suis efficace pour établir des liens avec de nouvelles personnes lors d’événements sociaux.": "4",
    "Je me sens épanoui en transformant mes idées en projets concrets remplis de créativité.": "5",
    "Je m'efforce de prioriser mes activités en fonction de leur importance et de l'urgence pour ne pas me sentir dépassé.": "6",
    "J'observe mes propres émotions, je suis capable d'appréhender celles des autres pour réagir de manière appropriée.": "7",
    "Je prends toujours la responsabilité de mes erreurs, cherchant à rectifier les choses plutôt que de les dissimuler.":
    "8",
    "Je suis celui qui prend l'initiative de planifier et de coordonner des événements, inspirant ainsi les autres à participer activement.":
    "9",
    "Je persévére jusqu'à ce que je finisse par atteindre mon but.":
    "10",
    "J'ai développé une capacité à rester stable émotionnellement et à faire preuve de sang froid.":
    "11"
  };

  final String _forwardScreenPath = RoutingUtil.jobDescriptionSchoolObjectFamiliesFormScreen;

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
                                      padding: const EdgeInsets.only(top: 12.0),
                                  child: SizedBox(
                                    height: 60.0,
                                    child: CheckboxListTile(
                                      enabled: _enabledItem(
                                          _mappingItems.keys.elementAt(index)),
                                      activeColor: ColorUtil.primary,
                                      title: Text(
                                          _mappingItems.keys.elementAt(index)),
                                      value: _selectedItems.contains(
                                          _mappingItems.keys.elementAt(index)),
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
                                            _selectedItems.remove(_mappingItems
                                                .keys
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
                                  JobDescriptionFormUtil.personalityTraitFamilies = _responses;
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
