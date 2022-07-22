import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_meal_app/providers/language_provider.dart';
import 'package:test_meal_app/providers/meal_provider.dart';
import 'package:test_meal_app/providers/theme_provider.dart';
import 'package:test_meal_app/screens/on_boarding_screen.dart';
import 'package:test_meal_app/screens/tabs_screen.dart';

import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/theme_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool('watched') ?? false)
      ? const TabsScreen()
      : const OnBoardingScreen();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (ctx) => MealProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (ctx) => LanguageProvider(),
      ),
    ],
    child: MyApp(
      homeScreen,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this.mainScreen, {
    Key? key,
  }) : super(key: key);
  final Widget mainScreen;

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(225, 254, 229, 1),
        fontFamily: 'Raleway',
        splashColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
            headline4: const TextStyle(
              color: Colors.black87,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            headline5: const TextStyle(
              color: Colors.black87,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            headline6: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      darkTheme: ThemeData(
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        splashColor: Colors.white70,
        cardColor: const Color.fromRGBO(24, 37, 51, 1),
        shadowColor: Colors.black54,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: const TextStyle(color: Colors.white60),
            headline4: const TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            headline5: const TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            headline6: const TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      routes: {
        '/': (ctx) => mainScreen,
        TabsScreen.routeName: (ctx) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen(),
        ThemesScreen.routeName: (context) => const ThemesScreen(),
      },
    );
  }
}
