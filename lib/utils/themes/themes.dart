import 'package:ecommerce/utils/themes/custom_themes/appbar_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/check_box_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/chip_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/outlined_button_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/text_form_theme.dart';
import 'package:ecommerce/utils/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class CustomAppTheme {
  CustomAppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: MyTextTheme.lightTextTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: MyCheckBoxTheme.lightCheckboxTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyInputDecorationTextTheme.lightInputDecorationTheme,
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: MyTextTheme.darkTextTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    scaffoldBackgroundColor: Colors.black,
    checkboxTheme: MyCheckBoxTheme.darkCheckboxTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MyInputDecorationTextTheme.darkInputDecorationTheme,
  );
}
