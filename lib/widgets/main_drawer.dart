import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';
import '../assetss/constant/constant.dart';

class MainDrawer extends StatelessWidget {
  final List<Meal> fvaoriteMeals;
  MainDrawer(this.fvaoriteMeals);
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: kListTileMainDraweTextStyle,
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration: kDecorationMainDrawer,
            child: Text(
              'CooKBooK',
              style: kMainDrawerTextstyle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabsScreen(1, fvaoriteMeals)));
            },
          ),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
          buildListTile(
            'Favorites',
            Icons.star,
            () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabsScreen(2, fvaoriteMeals)));
            },
          ),
        ],
      ),
    );
  }
}
