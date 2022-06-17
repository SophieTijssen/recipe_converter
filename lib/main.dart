import 'package:flutter/material.dart';
import 'package:recipe_converter/screens/recipe_screen.dart';

import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const RecipeScreen(),
    );
  }
}
