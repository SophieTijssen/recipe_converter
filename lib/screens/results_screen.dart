import 'package:flutter/material.dart';
import 'package:recipe_converter/create_data_table.dart';

import '../base_card.dart';
import '../ingredient.dart';
import '../theme.dart';

final columns = ["Amount", "Unit", "Ingredient"];

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}


class _ResultScreenState extends State<ResultScreen> {
  DataTable? ingredientTable;

  void buildDataTable() {
    ingredientTable = DataTable(
      columns: getColumns(context, columns),
      rows: getRows(ingredientsList, 'results'),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildDataTable();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Converted Ingredient List',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: <Widget>[
          BaseCard(
            theColor: Colors.white,
            theChild: Column(
              children: <Widget>[
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: SizedBox(
                //     width: 350.0,
                //     child: Text(
                //       'Converted ingredients:',
                //       style: TextStyle(fontSize: 22),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: ingredientsList.length >= 12 ? 632.0 : (ingredientsList.length * 48.0 + 56),
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
        ],
      ),
    );
  }
}
