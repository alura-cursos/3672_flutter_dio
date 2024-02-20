import 'package:flutter/material.dart';
import '../../model/product.dart';

class ProductListItem extends StatelessWidget {
  final String listinId;
  final Product produto;
  final bool isComprado;
  final Function showModal;
  final Function iconClick;
  final Function trailClick;

  const ProductListItem({
    super.key,
    required this.listinId,
    required this.produto,
    required this.isComprado,
    required this.showModal,
    required this.iconClick,
    required this.trailClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModal(product: produto);
      },
      leading: Checkbox(
        value: isComprado,
        onChanged: (value) {
          iconClick(produto: produto, listinId: listinId);
        },
      ),
      trailing: IconButton(
        onPressed: (() {
          trailClick(produto);
        }),
        icon: const Icon(Icons.delete),
      ),
      title: Text(
        (produto.amount == null)
            ? produto.name
            : "${produto.name} (x${produto.amount!.toInt()})",
      ),
      subtitle: Text(
        (produto.price == null)
            ? "Clique para adicionar preço"
            : "R\$ ${produto.price!}",
      ),
    );
  }
}
