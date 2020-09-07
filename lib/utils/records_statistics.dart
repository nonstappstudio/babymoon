import 'package:babymoon/models/record.dart';

class RecordsStatistics {

  static String averageSleepDurationinMinutes(List<Record> records) {

    int totalSleepTimeInMinutes = 0;

    records.forEach((r) { 
      totalSleepTimeInMinutes += r.durationInMinutes;
    });

    String avg = (totalSleepTimeInMinutes / 60).toStringAsFixed(2);
    
    return '${avg.split('.')[0]}h ${avg.split('.')[1]}m';
  }
}