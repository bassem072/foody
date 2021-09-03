import 'package:flutter/material.dart';
import 'package:foody/helper.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:foody/screens/filters_screen.dart';
import 'package:foody/screens/tabs_screen.dart';
import 'package:foody/screens/themes_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, Function() tabHandler, BuildContext ctx) {
    return ListTile(
      onTap: tabHandler,
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        '$title',
        style: TextStyle(
            color: Theme.of(ctx).textTheme.bodyText1!.color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Provider.of<LanguageProvider>(context).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                toText('drawer_name', context),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(toText('drawer_item1', context), Icons.restaurant,
                () => Navigator.of(context).pushNamed(TabsScreen.routeName), context),
            buildListTile(
                toText('drawer_item2', context),
                Icons.settings,
                () => Navigator.of(context).pushNamed(FiltersScreen.routeName),
                context),
            buildListTile(
                toText('drawer_item3', context),
                Icons.color_lens,
                () => Navigator.of(context).pushNamed(ThemesScreen.routeName),
                context),
            Divider(
              height: 3,
            ),
            Text(toText('drawer_switch_title', context)),
            Row(
              children: [
                Text(toText('drawer_switch_item2', context)),
                Switch(
                  value:
                      Provider.of<LanguageProvider>(context, listen: true).isEn,
                  onChanged: (bool newVal) =>
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLang(newVal),
                ),
                Text(toText('drawer_switch_item1', context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
