
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/common/common.dart';
import 'package:practice_project/common/themes.dart';
import 'package:practice_project/res/colors.dart';
import 'package:practice_project/res/styles.dart';

class ThemeProvider extends ChangeNotifier {

  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark", Themes.LIGHT : "Light", Themes.SYSTEM : "System"
  };
  
  void syncTheme(){
    String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]){
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    SpUtil.putString(Constant.theme, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false}) {
    String theme = SpUtil.getString(Constant.theme);
    switch(theme){
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }

    return ThemeData(
      errorColor: isDarkMode ? Colours.dark_red : Colours.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // Tab
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 
      scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      // 
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
      // 
      textSelectionColor: Colours.app_main.withAlpha(70),
      textSelectionHandleColor: Colours.app_main,
      textTheme: TextTheme(
        // TextField
        subhead: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文
        body1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        subtitle: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      )
    );
  }

}