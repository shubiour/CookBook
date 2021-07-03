import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kAppbarTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w400,
);
const kUserGreetingTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);
const kActiveCardColor = Color(0xFF8D8E98);

const kMenuCategoryTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kIngrededientsTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

final ThemeData kthemeData = ThemeData(
  //primaryIconTheme: IconThemeData(color: Colors.black),
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  accentColor: Colors.purple[300],
  scaffoldBackgroundColor: Colors.grey[100],
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme.copyWith(
      body1: TextStyle(
        color: Color.fromRGBO(20, 51, 51, 1),
      ),
      body2: TextStyle(
        color: Color.fromRGBO(20, 51, 51, 1),
      ),
      title: TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      )),
);

const kMainDrawerTextstyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 30,
  color: Colors.white,
);

const kDecorationMainDrawer = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
      Color(0xFF5032b6),
      Color(0xFFb765d3),
    ]));

const kListTileMainDraweTextStyle = TextStyle(
  fontFamily: 'RobotoCondensed',
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
