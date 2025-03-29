class FilterApplySchema {
  final String caratFrom;
  final String caratTo;
  final Set<String> lab;
  final Set<String> shape;
  final Set<String> color;
  final Set<String> clarity;

  FilterApplySchema({
    required this.caratFrom,
    required this.caratTo,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
  });

  /// create an object with default empty value in every fields.
  factory FilterApplySchema.newEmpty() => FilterApplySchema(
        caratFrom: "",
        caratTo: "",
        lab: {},
        shape: {},
        color: {},
        clarity: {},
      );

  copyWith({
    String? caratFrom,
    String? caratTo,
    Set<String>? lab,
    Set<String>? shape,
    Set<String>? color,
    Set<String>? clarity,
  }) =>
      FilterApplySchema(
        caratFrom: caratFrom ?? this.caratFrom,
        caratTo: caratTo ?? this.caratTo,
        lab: lab ?? this.lab,
        shape: shape ?? this.shape,
        color: color ?? this.color,
        clarity: clarity ?? this.clarity,
      );

  // return true if any one will be selected.
  // if all the filters are empty or not selected. then it will return false.
  bool get canApplyFilter =>
      caratFrom.isNotEmpty ||
      caratTo.isNotEmpty ||
      lab.isNotEmpty ||
      shape.isNotEmpty ||
      color.isNotEmpty ||
      clarity.isNotEmpty;

  // return if the value is selected in the filters.
  List<String> get appliedFiltersList => [
        if (caratFrom.isNotEmpty) ...{
          "Carat From: $caratFrom",
        },
        if (caratTo.isNotEmpty) ...{
          "Carat To: $caratTo",
        },
        if (lab.isNotEmpty) ...{
          "Lab: ${[...lab]}"
        },
        if (shape.isNotEmpty) ...{
          "Shape: ${[...shape]}"
        },
        if (color.isNotEmpty) ...{
          "Color: ${[...color]}"
        },
        if (clarity.isNotEmpty) ...{
          "Clarity: ${[...clarity]}"
        },
      ];
}
