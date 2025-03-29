class FilterDataSchema {
  double caratFromMin;
  double caratToMax;
  final Set<String> labs;
  final Set<String> shapes;
  final Set<String> colors;
  final Set<String> clarity;

  FilterDataSchema({
    this.caratFromMin = 0,
    this.caratToMax = 0,
    required this.labs,
    required this.shapes,
    required this.colors,
    required this.clarity,
  });
}
