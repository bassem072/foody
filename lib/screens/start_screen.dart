import 'package:flutter/material.dart';
import 'package:foody/screens/on_boarding_screen.dart';
import 'package:foody/screens/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getBool('watched') ?? false
          ? Navigator.of(context).pushNamed(TabsScreen.routeName)
          : Navigator.of(context).pushNamed(OnBoardingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
