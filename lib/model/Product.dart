class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        MEASURE_DT: json['MEASURE_DT'],
        TRANSACTION_SEQ: json['TRANSACTION_SEQ'],
        M00001: json['M00001'],
        M00002: json['M00002'],
        M00003: json['M00003'],
        M00004: json['M00004'],
        M00005: json['M00005'],
        M00006: json['M00006'],
        M00007: json['M00007'],
        M00008: json['M00008']);
  }

  Product({
    this.MEASURE_DT,
    this.TRANSACTION_SEQ,
    this.M00001,
    this.M00002,
    this.M00003,
    this.M00004,
    this.M00005,
    this.M00006,
    this.M00007,
    this.M00008,
  });

  String? MEASURE_DT;
  String? TRANSACTION_SEQ;
  double? M00001;
  double? M00002;
  double? M00003;
  double? M00004;
  double? M00005;
  double? M00006;
  double? M00007;
  double? M00008;
}