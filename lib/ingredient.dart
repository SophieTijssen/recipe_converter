class Ingredient {
  final String name;
  final double initialAmount;
  final String? initialUnit;
  final double newAmount;
  final String? preferredUnit;

  const Ingredient({
    required this.name,
    required this.initialAmount,
    required this.initialUnit,
    required this.newAmount,
    required this.preferredUnit,
  });

  Ingredient copy({
    String? name,
    double? initialAmount,
    String? initialUnit,
    double? newAmount,
    String? preferredUnit,
  }) =>
      Ingredient(
          name: name ?? this.name,
          initialAmount: initialAmount ?? this.initialAmount,
          initialUnit: initialUnit ?? this.initialUnit,
          newAmount: newAmount ?? this.newAmount,
          preferredUnit: preferredUnit ?? this.preferredUnit
      );
}

List<Ingredient> ingredientsList = <Ingredient>[];
