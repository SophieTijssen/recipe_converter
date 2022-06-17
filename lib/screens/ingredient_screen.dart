import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_converter/base_card.dart';

import '../ingredient.dart';
import '../measurement.dart';
import '../theme.dart';

const weightMenuItems = [
  DropdownMenuItem<Measurement>(child: Text('g', style: TextStyle(fontSize: 18.0),), value: Measurement.g,),
  DropdownMenuItem<Measurement>(child: Text('oz', style: TextStyle(fontSize: 18.0),), value: Measurement.oz,),
  DropdownMenuItem<Measurement>(child: Text('lb', style: TextStyle(fontSize: 18.0),), value: Measurement.lb,),
];

const volumeMenuItems = [
  DropdownMenuItem<Measurement>(child: Text('mL', style: TextStyle(fontSize: 18.0),), value: Measurement.mL,),
  DropdownMenuItem<Measurement>(child: Text('cup', style: TextStyle(fontSize: 18.0),), value: Measurement.cup,),
  DropdownMenuItem<Measurement>(child: Text('tbsp', style: TextStyle(fontSize: 18.0),), value: Measurement.tbsp,),
  DropdownMenuItem<Measurement>(child: Text('tsp', style: TextStyle(fontSize: 18.0),), value: Measurement.tsp,),
  DropdownMenuItem<Measurement>(child: Text('fl oz', style: TextStyle(fontSize: 18.0),), value: Measurement.flOz,),
];

AlertDialog createWarningMessage(BuildContext context, String title, String body) {
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: const TextStyle(fontSize: 24),
    ),
    content: Text(
      body,
      style: const TextStyle(fontSize: 20),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Close'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
  return alert;
}

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  MeasurementType measurementType = MeasurementType.weight;

  final _ingredient = TextEditingController();
  final _amount = TextEditingController();
  Measurement? _current;
  Measurement? _preferred;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Ingredient',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BaseCard(
              theColor: Colors.white,
              theChild: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredient:',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _ingredient,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0)
                        )
                      ),
                      hintText: 'e.g. Flour',
                    ),
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10.0,
                  ),
                  const SizedBox(
                    width: 190.0,
                    child: Text(
                      'Measurement type:',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  BaseCard(
                    theColor: measurementType == MeasurementType.weight ? focusBackground : primaryColor,
                    theChild: Container(
                      width: 70.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Text(
                        'Weight',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    theOnTapFunc: () {
                      setState(() {
                        _current = null;
                        _preferred = null;
                        measurementType = MeasurementType.weight;
                      });
                    },
                  ),
                  BaseCard(
                    theColor: measurementType == MeasurementType.volume ? focusBackground : primaryColor,
                    theChild: Container(
                      width: 75.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Text(
                        'Volume',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    theOnTapFunc: () {
                      setState(() {
                        _current = null;
                        _preferred = null;
                        measurementType = MeasurementType.volume;
                      });
                    },
                  ),
                ],
              ),
            ),
            BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 100.0,
                    child: Text(
                      'Amount:',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    width: 160.0,
                    child: TextField(
                      controller: _amount,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0)
                          )
                        ),
                        hintText: 'e.g. 250',
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  SizedBox(
                    width: 85.0,
                    child: DropdownButton(
                      items: measurementType == MeasurementType.weight ? weightMenuItems : volumeMenuItems,
                      hint: const Text(
                        'current unit',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      value: _current,
                      onChanged: (Measurement? selectedValue) {
                        setState(() {
                          _current = selectedValue;
                        });
                      },
                      iconEnabledColor: primaryColor,
                      isExpanded: true,
                    ),
                  ),
                ],
              ),
            ),
            BaseCard(
              theColor: Colors.white,
              theChild: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 102.0,
                    child: Text(
                      'Convert to:',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  const SizedBox(
                    width: 35.0,
                  ),
                  SizedBox(
                    width: 222.0,
                    child: DropdownButton(
                      items: measurementType == MeasurementType.weight ? weightMenuItems : volumeMenuItems,
                      hint: const Text(
                        'preferred unit',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      value: _preferred,
                      onChanged: (Measurement? selectedValue) {
                        setState(() {
                          _preferred = selectedValue;
                        });
                      },
                      iconEnabledColor: primaryColor,
                      isExpanded: true,
                    ),
                  ),
                ],
              ),
            ),
            BaseCard(
              theColor: primaryColor,
              theChild: const SizedBox(
                width: 70.0,
                height: 40.0,
                child: Center(
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              theOnTapFunc: () {
                if (_current == null || _preferred == null) {
                  AlertDialog alert = createWarningMessage(context, 'Warning', 'Could not do conversion because no units were given.');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else if (_amount.text == '') {
                  AlertDialog alert = createWarningMessage(context, 'Warning', 'Could not do conversion because no amount was given.');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else {
                  double? result;
                  if (_current == _preferred) {
                    result = double.parse(_amount.text);
                  } else {
                    for (var i = 0; i < conversions.length; i++) {
                      if (conversions[i].item1 == _current && conversions[i].item2 == _preferred) {
                        result = double.parse(_amount.text) * conversions[i].item3;
                        break;
                      } else if (conversions[i].item1 == _preferred && conversions[i].item2 == _current) {
                        result = double.parse(_amount.text) / conversions[i].item3;
                        break;
                      }
                    }
                  }

                  if (result == null) {
                    AlertDialog alert = createWarningMessage(context, 'Error', 'Could not find a conversion rate for the specified conversion.');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );

                  } else {
                    String? currentString, preferredString;
                    for (var i = 0; i < measurementStrings.length; i++) {
                      if (measurementStrings[i].item1 == _current) {
                        currentString = measurementStrings[i].item2;
                      }
                      if (measurementStrings[i].item1 == _preferred) {
                        preferredString = measurementStrings[i].item2;
                      }
                    }

                    Ingredient ingredient = Ingredient(name: _ingredient.text, initialAmount: double.parse(_amount.text), initialUnit: currentString, newAmount: result, preferredUnit: preferredString);
                    ingredientsList.add(ingredient);
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
