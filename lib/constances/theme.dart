import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


class MyColor {
  static Color red = Color.fromRGBO(255, 28, 39, 1);
  static Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color black = Color.fromRGBO(5, 5, 5, 1);
  static Color mainColor = HexColor('#ac1457');
}

navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

ThemeData lightTheme(context) => ThemeData(
    cardTheme: CardTheme(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            OutlineInputBorder(borderSide: BorderSide(color: MyColor.black))),
    scaffoldBackgroundColor: MyColor.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: HexColor('#ac1457'),
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: MyColor.white, fontSize: 30),
        elevation: 0.0,
        iconTheme: IconThemeData(color: MyColor.white),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: HexColor('#ac1457')),
        backwardsCompatibility: false),
    inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.9)),
        labelStyle: Theme.of(context).textTheme.subtitle2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: MyColor.black),
      bodyText2: TextStyle(color: MyColor.black),
      subtitle1: TextStyle(color: MyColor.black),
      subtitle2: TextStyle(color: MyColor.black),
      headline6: TextStyle(color: MyColor.black),
    ));

ThemeData darkTheme(context) => ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: HexColor('#2D3C48'),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.white, width: 3),
            borderRadius: BorderRadius.circular(50.0))),
    iconTheme: IconThemeData(color: MyColor.white),
    cardColor: HexColor('#2D3C48'),
    cardTheme: CardTheme(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            OutlineInputBorder(borderSide: BorderSide(color: MyColor.white))),
    scaffoldBackgroundColor: HexColor('#2D3C48'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
    ),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        color: HexColor('#2D3C48'),
        elevation: 0.0,
        iconTheme: IconThemeData(color: MyColor.white),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            statusBarColor: HexColor('#2D3C48')),
        backwardsCompatibility: false),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.white, width: 1.9),
            borderRadius: BorderRadius.circular(5.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.9)),
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: MyColor.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: MyColor.white),
      bodyText2: TextStyle(color: MyColor.white),
      subtitle1: TextStyle(color: MyColor.white),
      subtitle2: TextStyle(color: MyColor.white),
      headline6: TextStyle(color: MyColor.white),
    ));
