import 'package:ape_manager_front/models/Article.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class QuantiteBouton extends StatefulWidget {
  final Article article;
  final Function ajouterArticle;
  final Function retirerArticle;

  const QuantiteBouton(
      {super.key,
      required this.ajouterArticle,
      required this.article,
      required this.retirerArticle});

  @override
  State<QuantiteBouton> createState() => _QuantiteBoutonState();
}

class _QuantiteBoutonState extends State<QuantiteBouton> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: quantity == 0 ? BLEU : VERT,
        child: SizedBox(
          height: 50,
          width: ResponsiveConstraint.getResponsiveValue(context, 115.0, 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (quantity > 0)
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 0) quantity--;
                      widget.retirerArticle(widget.article);
                    });
                  },
                ),
              if (quantity <= 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Icon(
                    Icons.remove,
                    color: Colors.transparent,
                  ),
                ),
              Expanded(
                child: Text(
                  quantity.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: BLANC),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                    widget.ajouterArticle(widget.article);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
