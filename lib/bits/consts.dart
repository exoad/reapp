import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import './content_pipe.dart';

final class LaF {
  static const Color empty = Color.fromARGB(0, 0, 0, 0);
  static const Color primaryBackground =
      Color.fromARGB(255, 247, 237, 225);
  static const Color primaryColor =
      Color.fromARGB(255, 247, 204, 147);
  static const Color primaryColorTint =
      Color.fromARGB(255, 235, 208, 118);
  static const Color primaryColorConstrast =
      Color.fromARGB(255, 255, 145, 0);
  static const Color primaryColorFgContrast =
      Color.fromARGB(255, 48, 48, 48);

  static const Color primaryColorGreenTint =
      Color.fromARGB(255, 156, 230, 159);
  static const Color primaryColorBlueTint =
      Color.fromARGB(255, 156, 212, 238);

  static bool useLabeledBottomAppBarButtons = true;

  static const EdgeInsets outerComponentPadding =
      EdgeInsets.only(bottom: 8, left: 6, right: 6, top: 8);
  static const Radius roundedRectBorderRadius = Radius.circular(20);

  static String languageLocale = "en_US"; // ! NOTE: this is default
}

ThemeData appLaF() {
  return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: LaF.primaryBackground,
      bottomAppBarTheme: const BottomAppBarTheme(
          color: LaF.primaryColor,
          height: 80,
          surfaceTintColor: LaF.primaryColorTint,
          shadowColor: LaF.empty,
          shape: AutomaticNotchedShape(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(LaF.roundedRectBorderRadius)))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: LaF.primaryColorConstrast,
          foregroundColor: LaF.primaryColorFgContrast,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(LaF.roundedRectBorderRadius))),
      shadowColor: LaF.empty,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(
            LaF.primaryColorFgContrast),
      )),
      iconTheme:
          const IconThemeData(color: LaF.primaryColorFgContrast));
}

late YamlMap uiText;

Future<void> init() async {
  uiText = await loadYaml(
      loadString_sync("assets/i18n/${LaF.languageLocale}.yaml"));

  uiText.forEach((k, v) => print("Loaded LOCALE_LANG: $k -> $v"));
}
