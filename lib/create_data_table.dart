import 'package:flutter/material.dart';

import '../ingredient.dart';

List<DataColumn> getColumns(BuildContext context, List<String> columns) => columns
  .map((String column) => DataColumn(
    label: Text(
      column,
      style: Theme.of(context).textTheme.headline2,
    ),
  )).toList();

List<DataRow> getRows(List<Ingredient> ingredients, String screen) => ingredients
  .map((Ingredient ingredient) {
    final List cells;
    if (screen == 'results') {
      cells = [double.parse((ingredient.newAmount).toStringAsFixed(2)), ingredient.preferredUnit, ingredient.name];
    } else { // screen == initial
      cells = [double.parse((ingredient.initialAmount).toStringAsFixed(2)), ingredient.initialUnit, ingredient.name];
    }
    return DataRow(cells: getCells(cells));
  }).toList();

List<DataCell> getCells(List<dynamic> cells) => cells
  .map((data) => DataCell(
    Text(
      '$data',
      style: const TextStyle(fontSize: 16),
    )
  )).toList();
