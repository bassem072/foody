import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.color,
  }) : super(key: key);

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id' : id,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          toText('cat-$id', context),
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.4),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
