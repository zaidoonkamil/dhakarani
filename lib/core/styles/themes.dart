import 'package:flutter/material.dart';
import 'colors.dart';

class ThemeService{

  final lightTheme = ThemeData(
    dialogBackgroundColor: lightScaffoldBackgroundColor,
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    primaryColor: primaryColor,
    fontFamily: 'Tajawal',
    brightness: Brightness.light,
    dividerColor: lightDivideColor,
    backgroundColor: lightContainerGridOfCompleteShopColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal
      ),
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: lightScaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor:unselectedItemColorBottomNavigationBar,
      backgroundColor: colorBottomNavigationBar,
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(),
        buttonColor: Colors.black87
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black87,
      dividerColor: primaryColor,

    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      backgroundColor: lightScaffoldBackgroundColor,
      titleTextStyle: TextStyle(
          fontSize: 20,
          color: primaryColor,
          fontWeight: FontWeight.bold
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1E1E1C)),
      )
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      ),
      bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: lightPrimaryTextColor,
          fontFamily: 'Tajawal'
      ),
      headline1: TextStyle(
          fontSize: 10,
          color: lightPrimaryTextColor,
          fontFamily: 'Tajawal'
      ),
      headline2: TextStyle(
          fontSize: 16,
          color: lightTextButtonColor,
          fontFamily: 'Tajawal'
      ),
      headline3: const TextStyle(
          fontSize: 16,
          color: Color(0xFF7B7B7B),
          fontFamily: 'Tajawal'
      ),
    ),
  );
}

