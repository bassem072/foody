import 'package:flutter/material.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/meal_provider.dart';
import 'package:foody/providers/theme_provider.dart';
import 'package:foody/screens/categories_screen.dart';
import 'package:foody/screens/category_meals_screen.dart';
import 'package:foody/screens/filters_screen.dart';
import 'package:foody/screens/meal_detail_screen.dart';
import 'package:foody/screens/on_boarding_screen.dart';
import 'package:foody/screens/start_screen.dart';
import 'package:foody/screens/tabs_screen.dart';
import 'package:foody/screens/themes_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) => LanguageProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context, listen: true).themeMode,
      theme: ThemeData(
          primaryColor:
              Provider.of<ThemeProvider>(context, listen: true).primaryColor,
          accentColor:
              Provider.of<ThemeProvider>(context, listen: true).accentColor,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          cardColor: Colors.white,
          buttonColor: Colors.black87,
          shadowColor: Colors.white60,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                headline6: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      darkTheme: ThemeData(
          primaryColor:
              Provider.of<ThemeProvider>(context, listen: true).primaryColor,
          accentColor:
              Provider.of<ThemeProvider>(context, listen: true).accentColor,
          canvasColor: Color.fromRGBO(14, 22, 33, 1),
          fontFamily: 'Raleway',
          cardColor: Color.fromRGBO(35, 34, 39, 1),
          buttonColor: Colors.white70,
          shadowColor: Colors.black54,
          unselectedWidgetColor: Colors.white70,
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Colors.white60,
                ),
                headline6: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => StartScreen(),
        TabsScreen.routeName: (context) => TabsScreen(),
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal App'),
      ),
      body: CategoriesScreen(),
    );
  }
}
