class DayObj {

  final int timestamp;
  int sleepDuration;

  DayObj({
    this.timestamp,
    this.sleepDuration
  });

  factory DayObj.fromJson(dynamic jsonObj) {
    return DayObj(
      timestamp: jsonObj['timestamp'],
      sleepDuration: jsonObj['sleepDuration']
    ); 
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'sleepDuration': sleepDuration
  };
}