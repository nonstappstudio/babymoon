import 'package:babymoon/models/day.dart';
import 'package:sembast/sembast.dart';
import '../app_database.dart';

class DayRepository {

  static final database = AppDatabase.instance.database;

  static const String folderName = "days";
  static final daysFolder = intMapStoreFactory.store(folderName);


  static Future<List<DayObj>> getAllDays(int limit) async {

    final snapshot = await daysFolder.find(await database);

    return snapshot.map((s){
      final day = DayObj.fromJson(s.value);
      return day;
    }).toList();
  }

  static Future<bool> insertDay(DayObj day) async {

    final result = await daysFolder.add(await database, day.toJson());

    return result != null;
  }

  static Future<bool> updateDay(DayObj day) async {

    final finder = Finder(filter: Filter.equals('timestamp', day.timestamp));
    final result = await daysFolder
                  .update(await database, day.toJson(), finder: finder);

    return result != null;
    
  }

  static Future<bool> deleteAllDays() async {

    final result = await daysFolder.delete(await database);

    return result != null;
  }
}