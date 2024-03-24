import 'package:ape_manager_front/models/donnee_tableau.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:flutter/material.dart';

class Tableau extends StatefulWidget {
  final int tailleTableau;
  final Function? editable;
  final Function? supprimable;
  final Function? consultable;
  final List<DonneeTableau> objets;
  final DonneeTableau modele;
  final String? nomTableau;

  Tableau({
    super.key,
    required this.modele,
    required this.objets,
    this.tailleTableau = 300,
    this.editable,
    this.supprimable,
    this.consultable,
    this.nomTableau = "",
  });

  @override
  _TableauState createState() => _TableauState();
}

class _TableauState extends State<Tableau> {
  late List<String> _intitulesHeader;
  Map<String, bool> trie = {};

  void createTrieFromData() {
    for (var donnee in _intitulesHeader) {
      if (!trie.containsKey(donnee)) {
        trie[donnee] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _intitulesHeader = widget.modele.intitulesHeader();
    createTrieFromData();
    return Column(
      children: [
        Container(
          height: 50,
          color: BEIGE_FONCE,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              for (var columnName in _intitulesHeader)
                Expanded(
                  child: InkWell(
                    onTap: () => _sort(columnName),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          columnName,
                          style: FontUtils.getFontApp(
                            fontSize: ResponsiveConstraint.getResponsiveValue(
                                context,
                                POLICE_MOBILE_NORMAL_2,
                                POLICE_DESKTOP_NORMAL_2),
                          ),
                        ),
                        Icon(
                          (trie[columnName] ?? true)
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: NOIR,
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    if (widget.consultable != null && estDesktop(context, 600))
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.search,
                          color: Colors.transparent,
                        ),
                      ),
                    if (widget.editable != null && estDesktop(context, 600))
                      const Icon(
                        Icons.edit,
                        color: Colors.transparent,
                      ),
                    if (widget.supprimable != null && estDesktop(context, 600))
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.transparent,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(maxHeight: widget.tailleTableau - 50),
          child: widget.objets.isEmpty
              ? Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Aucune donnée à afficher",
                          textAlign: TextAlign.center,
                          style: FontUtils.getFontApp(
                              fontSize: ResponsiveConstraint.getResponsiveValue(
                                  context,
                                  POLICE_MOBILE_NORMAL_2,
                                  POLICE_DESKTOP_NORMAL_2)),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.objets.length,
                  itemBuilder: (context, index) {
                    final item = widget.objets[index];
                    return Container(
                      color: index.isOdd ? Colors.grey[200] : null,
                      child: ListTile(
                        onLongPress: () {
                          if (estMobile(context, 600) &&
                              (widget.editable != null ||
                                  widget.supprimable != null ||
                                  widget.consultable != null))
                            afficherPopup(context, item);
                        },
                        title: Row(
                          children: [
                            for (var nom_colonne in _intitulesHeader)
                              item.getValeur(nom_colonne).runtimeType == bool
                                  ? Expanded(
                                      child: Checkbox(
                                        tristate: true,
                                        value: item.getValeur(nom_colonne),
                                        onChanged: null,
                                      ),
                                    )
                                  : Expanded(
                                      child: Text(
                                        item
                                                    .getValeur(nom_colonne)
                                                    .toString() ==
                                                "null"
                                            ? '-'
                                            : item
                                                .getValeur(nom_colonne)
                                                .toString(),
                                        textAlign: TextAlign.center,
                                        style: FontUtils.getFontApp(
                                          fontSize: ResponsiveConstraint
                                              .getResponsiveValue(
                                                  context,
                                                  POLICE_MOBILE_NORMAL_2,
                                                  POLICE_DESKTOP_NORMAL_2),
                                          fontWeight: FONT_WEIGHT_NORMAL,
                                        ),
                                      ),
                                    ),
                            if (widget.consultable != null &&
                                estDesktop(context, 600))
                              BoutonIcon(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  widget.consultable!(item);
                                },
                              ),
                            if (widget.editable != null &&
                                estDesktop(context, 600))
                              BoutonIcon(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  widget.editable!(item);
                                },
                              ),
                            if (widget.supprimable != null &&
                                estDesktop(context, 600))
                              BoutonIcon(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  widget.supprimable!(item);
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (estMobile(context, 600))
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: GRIS_CLAIR),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      getTexteTableau(),
                      style: FontUtils.getFontApp(
                          fontstyle: FontStyle.italic,
                          fontSize: 13,
                          color: GRIS_FONCE),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String getTexteTableau() {
    String result = "Restez appuyé pour ";
    if (widget.editable != null) {
      result += "modifier";
      if (widget.consultable != null || widget.supprimable != null) {
        result += ", ";
      }
    }
    if (widget.consultable != null) {
      result += "consulter";
      if (widget.supprimable != null) {
        result += ", ";
      }
    }
    if (widget.supprimable != null) {
      result += "supprimer";
    }
    result += ".";
    return result;
  }

  void afficherPopup(BuildContext context, DonneeTableau item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  item.toString(),
                  textAlign: TextAlign.center,
                  style: FontUtils.getFontApp(fontSize: POLICE_MOBILE_NORMAL_2),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              if (widget.editable != null && estMobile(context, 600))
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Modifier'),
                  onTap: () {
                    Navigator.pop(context);
                    widget.editable!(item);
                  },
                ),
              if (widget.supprimable != null && estMobile(context, 600))
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Supprimer'),
                  onTap: () {
                    Navigator.pop(context);
                    widget.supprimable!(item);
                  },
                ),
              if (widget.consultable != null && estMobile(context, 600))
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Consulter'),
                  onTap: () {
                    Navigator.pop(context);
                    widget.consultable!(item);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _sort(String columnName) {
    setState(() {
      if (trie.containsKey(columnName)) {
        bool ascending = trie[columnName] ?? true;
        widget.objets.sort((a, b) {
          dynamic aValue = a.getValeur(columnName).toString().toUpperCase();
          dynamic bValue = b.getValeur(columnName).toString().toUpperCase();
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        });
        trie[columnName] = !ascending;
      }
    });
  }
}
