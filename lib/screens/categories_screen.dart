import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_meal_app/providers/meal_provider.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: Provider.of<MealProvider>(context)
            .availableCategory
            .map(
              (catData) => CategoryItem(id: catData.id, color: catData.color),
            )
            .toList(),
      ),
    );
  }
}
