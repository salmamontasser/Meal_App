import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_meal_app/screens/categories_screen.dart';
import 'package:test_meal_app/screens/favorites_screen.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const routeName = 'tabs_screen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;
  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': lan.getTexts('categories'),
      },
      {
        'page': const FavoritesScreen(),
        'title': lan.getTexts('your_favorites'),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar:
            AppBar(title: Text(_pages[_selectedPageIndex]['title'].toString())),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: lan.getTexts('categories').toString(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
