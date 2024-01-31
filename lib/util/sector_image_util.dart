class SectorImageUtil {
  static String getPath(String sector) {
    switch (sector) {
      case "agricole":
        return "assets/sectors/agricole.png";

      case "manufacturier":
        return "assets/sectors/manufacturier.png";

      case "construction":
        return "assets/sectors/construction.png";

      case "énergie":
        return "assets/sectors/energie.png";

      case "éducation":
        return "assets/sectors/education.png";

      case "santé":
        return "assets/sectors/sante.png";

      case "services financiers":
        return "assets/sectors/services_financiers.png";

      case "hôtellerie et tourisme":
        return "assets/sectors/hotellerie_tourisme.png";

      case "information et communication":
        return "assets/sectors/information_communication.png";

      case "technologie et informatique":
        return "assets/sectors/technologie_informatique.png";

      case "services professionnels, scientifiques et techniques":
        return "assets/sectors/service_professionel_scientifique_technique.png";

      case "services publics et sociaux":
        return "assets/sectors/service_public_social.png";

      case "transports et logistique":
        return "assets/sectors/transport_logistique.png";

      case "commerce de gros et de détail":
        return "assets/sectors/commerce.png";

      case "immobilier":
        return "assets/sectors/immobilier.png";

      case "art, spectacle et loisirs":
        return "assets/sectors/art_spectacle_loisir.png";

      case "restauration":
        return "assets/sectors/restauration.png";

      case "exploitation minière et extraction":
        return "assets/sectors/exploitation_miniere_extraction.png";

      case "assurance et pensions":
        return "assets/sectors/assurance_pension.png";

      case "environnement et gestion des déchets":
        return "assets/sectors/environnement_gestion_dechet.png";

      case "recherche et développement":
        return "assets/sectors/recherche_developpement.png";

      case "gestion, comptabilité et administration":
        return "assets/sectors/gestion_comptabilite_administration.png";
      default:
        return "";
    }
  }
}
