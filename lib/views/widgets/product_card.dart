import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:products_register_crud/models/product_model.dart';

import 'custom_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {required this.cardTitle,
      required this.cardPrice,
      required this.productModel,
      this.cardDescription,
      this.onDelete,
      this.onUpdate,
      Key? key})
      : super(key: key);

  final String cardTitle;
  final double cardPrice;
  final String? cardDescription;
  final ProductModel? productModel;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        title: Text(widget.cardTitle),
        subtitle: Text('R\$' + widget.cardPrice.toString()),
        children: [
          /* Text(
            widget.cardDescription!,
          ), */
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildButton(
                  buttonTitle: 'Editar',
                  width: 150,
                  onPressed: widget.onUpdate,
                ),
                BuildButton(
                  buttonTitle: 'Deletar',
                  width: 150,
                  onPressed: widget.onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
