class Data {
  int day;
  int month;
  int year;

  Data({this.day, this.month, this.year});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return new Data(
      day: json['day'],
      month: json['month'],
      year: json['year']
    );
  }
}
