import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/models/meal.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal>? categoryMeals;
  String? categoryId;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeal =
        Provider.of<MealProvider>(context, listen: true).availableMeal;
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryId = routeArg['id'];
    categoryMeals = availableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: Provider.of<LanguageProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(toText('cat-$categoryId', context)),
        ),
        body: GridView.builder(
          itemCount: categoryMeals!.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: MealItem(
                meal: categoryMeals![index],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <= 400 ? 400 : 500,
            childAspectRatio: islandscape ? dw / (dw * 0.8) : dw / (dw * 0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        ),
      ),
    );
  }
}
