import 'package:tuple/tuple.dart';

enum MeasurementType {
  volume,
  weight
}

enum Measurement {
  mL, // volume
  cup, // volume
  tbsp, // volume
  tsp, // volume
  flOz, // volume
  g, // weight
  oz, // weight
  lb // weight
}

const measurementStrings = <Tuple2>[
  Tuple2<Measurement, String>(Measurement.mL, 'mL'),
  Tuple2<Measurement, String>(Measurement.cup, 'cup'),
  Tuple2<Measurement, String>(Measurement.tbsp, 'tbsp'),
  Tuple2<Measurement, String>(Measurement.tsp, 'tsp'),
  Tuple2<Measurement, String>(Measurement.flOz, 'fl oz'),
  Tuple2<Measurement, String>(Measurement.g, 'g'),
  Tuple2<Measurement, String>(Measurement.oz, 'oz'),
  Tuple2<Measurement, String>(Measurement.lb, 'lb'),
];

const conversions = <Tuple3>[
  Tuple3<Measurement, Measurement, double>(Measurement.g, Measurement.oz, 0.35),
  Tuple3<Measurement, Measurement, double>(Measurement.oz, Measurement.g, 28.0),
  Tuple3<Measurement, Measurement, double>(Measurement.lb, Measurement.oz, 16.0),
  Tuple3<Measurement, Measurement, double>(Measurement.lb, Measurement.g, 454.0),
  Tuple3<Measurement, Measurement, double>(Measurement.tsp, Measurement.mL, 5.0),
  Tuple3<Measurement, Measurement, double>(Measurement.tbsp, Measurement.mL, 15.0),
  Tuple3<Measurement, Measurement, double>(Measurement.flOz, Measurement.mL, 30.0),
  Tuple3<Measurement, Measurement, double>(Measurement.cup, Measurement.mL, 237.0),
  Tuple3<Measurement, Measurement, double>(Measurement.cup, Measurement.flOz, 8.0),
  Tuple3<Measurement, Measurement, double>(Measurement.cup, Measurement.tbsp, 16),
  Tuple3<Measurement, Measurement, double>(Measurement.cup, Measurement.tsp, 48),
  Tuple3<Measurement, Measurement, double>(Measurement.tbsp, Measurement.tsp, 3.0),
  Tuple3<Measurement, Measurement, double>(Measurement.flOz, Measurement.tbsp, 2.0),
  Tuple3<Measurement, Measurement, double>(Measurement.flOz, Measurement.tsp, 6.0),
];