class ChartData {
  Object? x;
  double? y;
  double? y1;
  ChartData({this.x, this.y, this.y1});
  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      x: json['x'],
      y: json['y'],
      y1: json['y1'],
    );
  }
}