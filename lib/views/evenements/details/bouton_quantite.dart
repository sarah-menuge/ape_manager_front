import 'package:ape_manager_front/models/article.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class QuantiteBouton extends StatefulWidget {
  final bool disabled;
  final int quantity;
  final Article article;
  final Function ajouterArticle;
  final Function retirerArticle;

  const QuantiteBouton({
    super.key,
    required this.ajouterArticle,
    required this.article,
    required this.retirerArticle,
    this.disabled = false,
    this.quantity = 0,
  });

  @override
  State<QuantiteBouton> createState() => _QuantiteBoutonState();
}

class _QuantiteBoutonState extends State<QuantiteBouton> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: widget.disabled
            ? Colors.transparent
            : quantity == 0
                ? BLEU
                : VERT_1,
        elevation: 0,
        child: SizedBox(
          height: 50,
          width: ResponsiveConstraint.getResponsiveValue(context, 115.0, 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (quantity > 0 && !widget.disabled)
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 0) quantity--;
                      widget.retirerArticle(widget.article);
                    });
                  },
                ),
              if (quantity <= 0 || widget.disabled)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Icon(
                    Icons.remove,
                    color: Colors.transparent,
                  ),
                ),
              Expanded(
                child: Text(
                  widget.disabled
                      ? "x ${quantity.toString()}"
                      : quantity.toString(),
                  textAlign: TextAlign.center,
                  style: FontUtils.getFontApp(
                      fontWeight:
                          widget.disabled ? FontWeight.normal : FontWeight.w300,
                      fontSize: ResponsiveConstraint.getResponsiveValue(context,
                          POLICE_MOBILE_NORMAL_2, POLICE_DESKTOP_NORMAL_2),
                      color: widget.disabled ? NOIR : BLANC),
                ),
              ),
              if (!widget.disabled)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                      widget.ajouterArticle(widget.article);
                    });
                  },
                ),
              if (widget.disabled)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Icon(
                    Icons.add,
                    color: Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
