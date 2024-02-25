import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/models/Evenement.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details_view_desktop.dart';
import 'package:ape_manager_front/views/evenements/details/evenements_details_view_mobile.dart';
import 'package:ape_manager_front/views/evenements/liste/evenements_view.dart';
import 'package:flutter/material.dart';

class EvenementsDetailsView extends StatelessWidget {
  static String routeName = '/evenements/details';

  final Evenement evenement = Evenement(
      titre: "Opération sortie bowling + pique-nique dans la forêt",
      description:
          "Vente de boîte de chocolat noir, au lait et blanc. Pralinés ou fourrés, avec cette opération vous trouverez le chocolat de vos rêves !",
      statut: "Clôturé",
      liste_articles: liste_articles);

  static Article article1 = Article(
    id: 1,
    nom: "Boîte de chocolat mixte",
    quantiteMax: 0,
    prix: 17.99,
    description:
        'Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g, Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g',
    categorie: 'Chocolat',
  );

  static Article article2 = Article(
    id: 2,
    nom: "Boîte de chocolat blanc",
    quantiteMax: 0,
    prix: 10.99,
    description: 'Boîte de chocolat blanc, 250g',
    categorie: 'Chocolat',
  );

  static Article article3 = Article(
    id: 1,
    nom: "Boîte de chocolat noir",
    quantiteMax: 0,
    prix: 25.99,
    description: 'Boîte de chocolat noir, 700g',
    categorie: 'Chocolat',
  );

  static Article article4 = Article(
    id: 1,
    nom: "Boîte de chocolat noir",
    quantiteMax: 0,
    prix: 25.99,
    description: 'Boîte de chocolat noir, 700g',
    categorie: 'Chocolat',
  );

  static Article article5 = Article(
    id: 1,
    nom: "Boîte de chocolat mixte",
    quantiteMax: 0,
    prix: 17.99,
    description:
        'Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g, Boîte de chocolat noir, blanc, au lait, pralinés et fourrés, 500g',
    categorie: 'Chocolat',
  );

  static Article article6 = Article(
    id: 2,
    nom: "Boîte de chocolat blanc",
    quantiteMax: 0,
    prix: 10.99,
    description: 'Boîte de chocolat blanc, 250g',
    categorie: 'Chocolat',
  );

  static Article article7 = Article(
    id: 1,
    nom: "Boîte de chocolat noir",
    quantiteMax: 0,
    prix: 25.99,
    description: 'Boîte de chocolat noir, 700g',
    categorie: 'Chocolat',
  );

  static Article article8 = Article(
    id: 1,
    nom: "Boîte de chocolat noir",
    quantiteMax: 0,
    prix: 25.99,
    description: 'Boîte de chocolat noir, 700g',
    categorie: 'Chocolat',
  );

  static List<Article> liste_articles = [
    article1,
    article2,
    article3,
    article4,
    article5,
    article6,
    article7,
    article8
  ];

  EvenementsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: EvenementsDetailsViewMobile(
        evenement: evenement,
        profil: Profil.Parent,
      ),
      desktopBody: EvenementsDetailsViewDesktop(
        evenement: evenement,
        profil: Profil.Parent,
      ),
    );
  }
}
