import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projects/add_item/item.dart';
import 'package:projects/add_item/item_model.dart';
import '../../favorite/favorite_model.dart';

class FavoriteWidget extends StatelessWidget {
  final int index;

  const FavoriteWidget({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<ItemModel>(context);
    final item = itemModel.items[index];

    return Consumer<FavoriteModel>(
      builder: (context, favoriteModel, child) {
        final isFavorite = favoriteModel.fav.contains(item);

        return IconButton(
          onPressed: () {
            if (isFavorite) {
              favoriteModel.remove(item);
            } else {
              favoriteModel.add(item);
            }
          },
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
