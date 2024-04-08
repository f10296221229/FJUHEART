class Product1{
  factory Product1.fromJson(Map<String, dynamic> json) {
    return Product1(
        MEASURE_DT: json['MEASURE_DT'],
        MEASURE_CODE_GRADE: json['MEASURE_CODE_GRADE'],
        MEASURE_NAME: json['MEASURE_NAME'],
        TRANSACTION_SEQ: json['TRANSACTION_SEQ'],
        MEASURE_CODE: json['MEASURE_CODE'],
        MEASURE_REMARK: json['MEASURE_REMARK'],
        PIC: json['PIC']
    );
  }

  Product1(
      {this.MEASURE_DT,
        this.MEASURE_CODE_GRADE,
        this.MEASURE_NAME,
        this.TRANSACTION_SEQ,
        this.MEASURE_CODE,
        this.MEASURE_REMARK,
        this.PIC
      });

  String? MEASURE_DT;
  double? MEASURE_CODE_GRADE;
  String? MEASURE_NAME;
  String? TRANSACTION_SEQ;
  String? MEASURE_CODE;
  String? MEASURE_REMARK;
  String? PIC;
}