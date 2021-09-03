import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  final fromOnBoarding;
  static const routeName = 'filters';
  FiltersScreen({this.fromOnBoarding = false});

  Widget _buildSwitchListTile(String title, bool currentValue,
      String description, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: false).filters;
    return WillPopScope(
      child: Directionality(
        textDirection: Provider.of<LanguageProvider>(context).isEn
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                title: fromOnBoarding
                    ? null
                    : Text(toText('filters_appBar_title', context)),
                backgroundColor:
                    fromOnBoarding ? null : Theme.of(context).primaryColor,
                elevation: fromOnBoarding ? 0 : 5,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        toText('filters_screen_title', context),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _buildSwitchListTile(
                      toText('Gluten-free', context),
                      Provider.of<MealProvider>(context, listen: true)
                              .filters['gluten'] ??
                          false,
                      toText('Gluten-free-sub', context),
                      (value) {
                        currentFilters['gluten'] = value;
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilter();
                      },
                    ),
                    _buildSwitchListTile(
                      toText('Lactose-free', context),
                      Provider.of<MealProvider>(context, listen: true)
                              .filters['lactose'] ??
                          false,
                      toText('Lactose-free_sub', context),
                      (value) {
                        currentFilters['lactose'] = value;
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilter();
                      },
                    ),
                    _buildSwitchListTile(
                      toText('Vegan', context),
                      Provider.of<MealProvider>(context, listen: true)
                              .filters['vegan'] ??
                          false,
                      toText('Vegan-sub', context),
                      (value) {
                        currentFilters['vegan'] = value;
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilter();
                      },
                    ),
                    _buildSwitchListTile(
                      toText('Vegetarian', context),
                      Provider.of<MealProvider>(context, listen: true)
                              .filters['vegetarian'] ??
                          false,
                      toText('Vegetarian-sub', context),
                      (value) {
                        currentFilters['vegetarian'] = value;
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilter();
                      },
                    ),
                    SizedBox(
                      height: fromOnBoarding ? 80 : 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: fromOnBoarding ? null : MainDrawer(),
        ),
      ),
      onWillPop: () async {
        Provider.of<MealProvider>(context, listen: false).setData();
        print('done');
        return true;
      },
    );
  }
}
