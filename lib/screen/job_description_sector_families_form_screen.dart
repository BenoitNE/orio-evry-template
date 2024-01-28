import 'package:flutter/material.dart';
import '../util/color_util.dart';
import '../util/font_util.dart';
import '../util/job_description_form_util.dart';
import '../util/routing_util.dart';
import '../widget/appbar_form_widget.dart';
import '../widget/button_form_widget.dart';
import '../util/dialog_util.dart';


class JobDescriptionSectorFamiliesFormScreen extends StatefulWidget {
  const JobDescriptionSectorFamiliesFormScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _JobDescriptionSectorFamiliesFormScreenState();
}

class _JobDescriptionSectorFamiliesFormScreenState
    extends State<JobDescriptionSectorFamiliesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _responses = [];
  final List<String> _selectedItems = [];
  final int _itemQuantityMax = 3;
  final String _title =
      "Parmi les phrases ci-dessous, veuillez choisir une à trois phrases qui vous semblent pertinentes et qui correspondent le mieux à vos préférences :";
  final String _dialogError = "Le nombre d'items sélectionnés est incorrect.";

  final Map<String, String> _mappingItems = {
    "J'aime être en contact avec la nature et prendre soin des plantes et des animaux.":
        "0",
    "Je trouve de la joie à couper, sculpter, assembler et tester des produits.":
        "1",
    "Je suis du genre à aimer les LEGO et à rêver de bâtir des merveilles concrètes.":
        "2",
    "Je suis curieux de savoir comment on produit et distribue de l'énergie.":
        "3",
    "J'aime partager des connaissances et aider les autres à apprendre.": "4",
    "S'occuper des autres et contribuer à leur bien-être me passionne.": "5",
    "Je suis doué pour gérer mon argent et planifier mes achats.": "6",
    "Le voyage, l'aventure et l'hospitalité m'anime.": "7",
    "J'aime partager des informations et des histoires de manière créative.":
        "8",
    "Je suis le genre de personne qui adore résoudre des problèmes avec des ordinateurs et des gadgets.":
        "9",
    "J'aime donner des conseils et résoudre des problèmes complexes dans divers domaines.":
        "10",
    "Le travail de bureau, l'assistance à la communauté et le respect des règles sont ma tasse de thé.":
        "11",
    "Je me vois m'occuper de la circulation de personnes et de biens.": "12",
    "Je prends plaisir à acheter, vendre et négocier des articles dont les gens ont besoin ou désirent.":
        "13",
    "Je me vois m'occuper des biens, que ce soit des maisons, des bureaux ou des terrains.":
        "14",
    "J'aime étonner les gens avec mon talent et ma sensibilité artistique, ainsi que divertir.":
        "15",
    "Cuisiner, servir et offrir aux gens une expérience gastronomique mémorable me plais.":
        "16",
    "Je suis fasciné par la terre et ce qui se cache sous sa surface.": "17",
    "Conseiller les gens sur leur futur, leur sécurité et les aider à planifier leurs projets, ça me parle.":
        "18",
    "Je suis passionné par la préservation de l'environnement et la gestion des ressources.":
        "19",
    "J'aimes découvrir de nouvelles choses, résoudre des énigmes et repousser les limites de ce que nous savons déjà.":
        "20",
    "J'aimerais évoluer professionnellement dans un domaine nécessitant du suivi financier et/ou de l'organisation de le traitement de documents.":
        "21"
  };

  final String _forwardScreenPath = RoutingUtil.jobDescriptionPersonalityTraitFamiliesFormScreen;

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
                                  JobDescriptionFormUtil.sectorFamilies = _responses;
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
