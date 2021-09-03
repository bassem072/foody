import 'package:flutter/material.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(20),
      children: Provider.of<MealProvider>(context).availableCategory
          .map(
            (category) => CategoryItem(
                id: category.id, color: category.color),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
