import 'package:babymoon/models/record.dart';

class RecordsStatistics {

  static String averageSleepDuration(List<Record> records) {

    int totalSleepTimeInMinutes = 0;

    records.forEach((r) { 
      totalSleepTimeInMinutes += r.durationInMinutes;
    });

    String avg = (totalSleepTimeInMinutes / 60).toStringAsFixed(2);
    
    return '${avg.split('.')[0]}h ${avg.split('.')[1]}m';
  }


  static String averageNapsDuration(List<Record> records) {

    int totalNapsTimeInMinutes = 0;

    records.where((r) => r.type == SleepType.NAP).forEach((r) { 
      totalNapsTimeInMinutes += r.durationInMinutes;
    });

    String avg = (totalNapsTimeInMinutes / 60).toStringAsFixed(2);
    
    return '${avg.split('.')[0]}h ${avg.split('.')[1]}m';
  }
}