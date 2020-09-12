import 'package:babymoon/models/record.dart';
import 'package:sembast/sembast.dart';
import '../app_database.dart';
import 'package:babymoon/utils/extensions/all_extensions.dart';

class RecordRepository {

  static var database = AppDatabase.instance.database;

  static const String folderName = "records";
  static final recordsFolder = intMapStoreFactory.store(folderName);

  static Future<List<Record>> getAllrecords() async {
    final database = await AppDatabase.instance.database;

    final finder = Finder(sortOrders: [SortOrder('dateTime', true)]);

    final recordSnapshot = await recordsFolder.find(database, finder: finder);

    return recordSnapshot.map((snapshot){
      final record = Record.fromJson(snapshot.value);
      return record;
    }).toList();
  }

  static Future<List<Record>> getSpecificType(SleepType type) async {
    final database = await AppDatabase.instance.database;

    final finder = Finder(
      filter: Filter.equals('type', type.dbSafeString)
    );

    final recordSnapshot = await recordsFolder.find(database, finder: finder);

    return recordSnapshot.map((snapshot){
      final record = Record.fromJson(snapshot.value);
      return record;
    }).toList();
  }

  static Future<bool> insertRecord(Record record) async {

    final database = await AppDatabase.instance.database;

    final result = await recordsFolder.add(database, record.toJson());

    return result != null;
  }

  static Future<bool> updateRecord(Record record) async {

    final finder = Finder(filter: Filter.byKey(record.id));
    final result = await recordsFolder
                  .update(await database, record.toJson(),finder: finder);

    return result != null;
    
  }

  static Future<bool> delete(Record record) async {
    final database = await AppDatabase.instance.database;

    final finder = Finder(filter: Filter.byKey(record.id));
    final result = await recordsFolder.delete(database, finder: finder);

    return result != null;
  }

  static Future<bool> deleteAllRecords() async {

    final result = await recordsFolder.delete(await database);

    return result != null;
  }
}