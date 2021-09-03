import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/providers/theme_provider.dart';
import 'package:foody/screens/categories_screen.dart';
import 'package:foody/screens/favorites_screen.dart';
import 'package:foody/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, String>> _pages;

  @override
  initState() {
    super.initState();
    Provider.of<MealProvider>(context, listen: false).setData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    _pages = [
      {
        'title': 'categories',
      },
      {
        'title': 'your_favorites',
      },
    ];
  }

  int _selectedPageIndex = 0;

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Provider.of<LanguageProvider>(context).isEn
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(toText(_pages[_selectedPageIndex]['title'] ?? '', context)),
        ),
        body: _selectedPageIndex == 0 ? CategoriesScreen() : FavoritesScreen(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: toText('categories', context),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: toText('your_favorites', context),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
