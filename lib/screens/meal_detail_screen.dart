import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foody/helper.dart';
import 'package:foody/models/meal.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meals_detail';

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "$title",
        style: Theme.of(ctx).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext ctx) {
    bool islandscape = MediaQuery.of(ctx).orientation == Orientation.landscape;
    var dw = MediaQuery.of(ctx).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: islandscape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, Meal>;
    final Meal meal = routeArg['meal']!;
    var accentColor = Theme.of(context).accentColor;
    List<String> ingredients = toObject('ingredients-${meal.id}', context);
    List<String> steps = toObject('steps-${meal.id}', context);

    ListView ingredientsList = ListView.builder(
      itemCount: ingredients.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            ingredients[index],
            style: TextStyle(
              color:
                  useWhiteForeground(accentColor) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );

    ListView stepsList = ListView.builder(
      itemCount: steps.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(
              steps[index],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );

    return Directionality(
      textDirection: Provider.of<LanguageProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  toText('meal-${meal.id}', context),
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
                background: Hero(
                      tag: meal.id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${meal.imageUrl}',
                          ),
                        ),
                      ),
                    ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (islandscape)
                    Row(
                      children: [
                        Column(
                          children: [
                            buildSectionTitle(
                                context, toText('Ingredients', context)),
                            buildContainer(ingredientsList, context),
                          ],
                        ),
                        Column(
                          children: [
                            buildSectionTitle(
                                context, toText('Steps', context)),
                            buildContainer(stepsList, context),
                          ],
                        ),
                      ],
                    ),
                  if (!islandscape) ...[
                    buildSectionTitle(context, toText('Ingredients', context)),
                    buildContainer(ingredientsList, context),
                    buildSectionTitle(context, toText('Steps', context)),
                    buildContainer(stepsList, context),
                  ],
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(meal.id),
          child: Icon(
            Provider.of<MealProvider>(context, listen: true)
                    .isMealFavorite(meal.id)
                ? Icons.star
                : Icons.star_border,
          ),
        ),
      ),
    );
  }
}
