import 'package:flutter/material.dart';
import 'package:recipe_converter/base_card.dart';
import 'package:recipe_converter/screens/results_screen.dart';
import 'package:recipe_converter/create_data_table.dart';

import '../ingredient.dart';
import '../theme.dart';
import 'ingredient_screen.dart';

final columns = ["Amount", "Unit", "Ingredient"];

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool showScaleSlider = false;
  double _scale = 1.0;

  Widget ingredientTable = const SizedBox.shrink();
  Widget scaleSlider = const SizedBox.shrink();
  Widget convertButton = const SizedBox.shrink();

  void buildDataTable() {
    ingredientTable = DataTable(
      columns: getColumns(context, columns),
      rows: getRows(ingredientsList, 'initial'),
    );
  }

  void buildConversionWidgets() {
    if (ingredientsList.isNotEmpty) {
      scaleSlider = BaseCard(
        theColor: background,
        theChild: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 10.0,
                ),
                const SizedBox(
                  width: 300.0,
                  child: Text(
                    'Scaling the ingredient',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Switch(
                  onChanged: (bool value) {
                    if (showScaleSlider == false) {
                      setState(() {
                        showScaleSlider = true;
                      });
                    } else {
                      setState(() {
                        showScaleSlider = false;
                        _scale = 1.0;
                      });
                    }
                  },
                  value: showScaleSlider,
                ),
              ],
            ),
            showScaleSlider == true
              ? BaseCard(
                theColor: background,
                theChild: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          _scale.toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          width: 290.0,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: Slider(
                                  value: _scale,
                                  min: 0.5,
                                  max: 2.0,
                                  divisions: (2.0 - 0.5) ~/ 0.5,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _scale = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
          ],
        ),
      );
      convertButton = BaseCard(
        theColor: primaryColor,
        theChild: const SizedBox(
          width: 110.0,
          height: 45.0,
          child: Center(
            child: Text(
              "Convert",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
          ),
        ),
        theOnTapFunc: () {
          for (var i = 0; i < ingredientsList.length; i++) {
            Ingredient ingredient = ingredientsList[i];
            double scaledResult = ingredient.newAmount * _scale;
            ingredientsList[i] = Ingredient(name: ingredient.name, initialAmount: ingredient.initialAmount, initialUnit: ingredient.initialUnit, newAmount: scaledResult, preferredUnit: ingredient.preferredUnit);
          }
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ResultScreen();
                },
              )
          );
        },
      );
    } else {
      scaleSlider = const SizedBox.shrink();
      convertButton = const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    buildDataTable();
    buildConversionWidgets();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Ingredient List',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BaseCard(
              theColor: background,
              theChild: Column(
                children: <Widget>[
                  SizedBox(
                    height: ingredientsList.length >= 8 ? 440.0 : (ingredientsList.length * 48.0 + 56.0),
                    width: 380.0,
                    child: Center(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ingredientTable,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            scaleSlider,
            convertButton,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) {
                return const DataEntryScreen();
              },
              )
            )
            .then((value) {
              setState(() {
                buildDataTable();
                buildConversionWidgets();
              });
            });
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}