import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:foody/helper.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/providers/theme_provider.dart';
import 'package:foody/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {
  final fromOnBoarding;
  static const routeName = 'themes';

  ThemesScreen({this.fromOnBoarding = false});
  Widget _buildRadioListTile(
      ThemeMode themeVal, String title, IconData? icon, BuildContext ctx) {
    return RadioListTile(
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).themeMode,
      title: Text(title),
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      onChanged: (newValTheme) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newValTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                  : Text(toText('theme_appBar_title', context)),
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
                      toText('theme_screen_title', context),
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      toText('theme_mode_title', context),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  _buildRadioListTile(ThemeMode.system,
                      toText('System_default_theme', context), null, context),
                  _buildRadioListTile(
                      ThemeMode.light,
                      toText('light_theme', context),
                      Icons.wb_sunny_outlined,
                      context),
                  _buildRadioListTile(
                      ThemeMode.dark,
                      toText('dark_theme', context),
                      Icons.nights_stay_outlined,
                      context),
                  buildListTile(context, 'primary'),
                  buildListTile(context, 'accent'),
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
    );
  }

  ListTile buildListTile(BuildContext ctx, String title) {
    Color primaryColor =
        Provider.of<ThemeProvider>(ctx, listen: true).primaryColor;
    Color accentColor =
        Provider.of<ThemeProvider>(ctx, listen: true).accentColor;

    return ListTile(
      title: Text(
        toText(title, ctx),
        style: Theme.of(ctx).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: title == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 4,
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: title == "primary"
                      ? Provider.of<ThemeProvider>(context, listen: true)
                          .primaryColor
                      : Provider.of<ThemeProvider>(context, listen: true)
                          .accentColor,
                  onColorChanged: (newColor) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .onChange(newColor, title == "primary" ? 1 : 2),
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: true,
                  showLabel: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
