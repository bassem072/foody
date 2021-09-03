import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/models/meal.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    final List<Meal>? favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favoriteMeals!.isEmpty) {
      return Center(
        child: Text(toText('favorites_text', context),),
      );
    } else {
      return GridView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            title: MealItem(
              meal: favoriteMeals[index],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: islandscape ? dw / (dw * 0.8) : dw / (dw * 0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
      );
    }
  }
}
