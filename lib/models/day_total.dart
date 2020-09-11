class DayTotal {

  final int dateTime;
  final int sleepDuration;

  DayTotal({
    this.dateTime,
    this.sleepDuration
  });

  factory DayTotal.fromJson(dynamic jsonObj) {
    return DayTotal(
      dateTime: jsonObj['dateTime'],
      sleepDuration: jsonObj['sleepDuration']
    ); 
  }

  Map<String, dynamic> toJson() => {
    'dateTime': dateTime,
    'sleepDuration': sleepDuration
  };
}