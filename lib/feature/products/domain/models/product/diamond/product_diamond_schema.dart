import 'package:kgk/core/utils/constants/app_types.dart';

class ProductDiamondSchema {
  final int qty;
  final String lotId;
  final String size;
  final double carat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final String cut;
  final String polish;
  final String symmetry;
  final String fluorescence;
  final double discount;
  final double perCaratRate;
  final double finalAmount;
  final String keyToSymbol;
  final String labComment;
  final bool isExpanded;
  final int cartCount;

  ProductDiamondSchema({
    required this.qty,
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
    this.isExpanded = false,
    this.cartCount = 0,
  });

  factory ProductDiamondSchema.fromJson(Json json) {
    return ProductDiamondSchema(
      qty: int.parse(json['Qty'].toString()),
      lotId: json['Lot ID'],
      size: json['Size'],
      carat: double.parse(json['Carat'].toString()),
      lab: json['Lab'],
      shape: json['Shape'],
      color: json['Color'],
      clarity: json['Clarity'],
      cut: json['Cut'],
      polish: json['Polish'],
      symmetry: json['Symmetry'],
      fluorescence: json['Fluorescence'],
      discount: double.parse(json['Discount'].toString().replaceAll(",", "")),
      perCaratRate:
          double.parse(json['Per Carat Rate'].toString().replaceAll(",", "")),
      finalAmount:
          double.parse(json['Final Amount'].toString().replaceAll(",", "")),
      keyToSymbol: json['Key To Symbol'],
      labComment: json['Lab Comment'].toString(),
    );
  }

  ProductDiamondSchema copyWith({
    int? qty,
    String? lotId,
    String? size,
    double? carat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
    String? cut,
    String? polish,
    String? symmetry,
    String? fluorescence,
    double? discount,
    double? perCaratRate,
    double? finalAmount,
    String? keyToSymbol,
    String? labComment,
    bool? isExpanded,
    int? cartCount,
  }) =>
      ProductDiamondSchema(
        qty: qty ?? this.qty,
        lotId: lotId ?? this.lotId,
        size: size ?? this.size,
        carat: carat ?? this.carat,
        lab: lab ?? this.lab,
        shape: shape ?? this.shape,
        color: color ?? this.color,
        clarity: clarity ?? this.clarity,
        cut: cut ?? this.cut,
        polish: polish ?? this.polish,
        symmetry: symmetry ?? this.symmetry,
        fluorescence: fluorescence ?? this.fluorescence,
        discount: discount ?? this.discount,
        perCaratRate: perCaratRate ?? this.perCaratRate,
        finalAmount: finalAmount ?? this.finalAmount,
        keyToSymbol: keyToSymbol ?? this.keyToSymbol,
        labComment: labComment ?? this.labComment,
        cartCount: cartCount ?? this.cartCount,
        isExpanded: isExpanded ?? this.isExpanded,
      );
}
