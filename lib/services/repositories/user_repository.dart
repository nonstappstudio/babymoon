import 'package:babymoon/models/user.dart';
import 'package:sembast/sembast.dart';

import '../app_database.dart';

class UserRepository {

  static var database = AppDatabase.instance.database;

  static const String folderName = "users";
  static final usersFolder = intMapStoreFactory.store(folderName);

  static Future<User> getUser() async {

    final usersSnapshot = await usersFolder.find(await database);

    return usersSnapshot.isNotEmpty
      ? User.fromJson(usersSnapshot[0].value)
      : null;
  }

  static Future<bool> insertUser(User user) async {

    final result = await usersFolder.add(await database, user.toJson());

    return result != null;
  }

  static Future<bool> updateUser(User user) async {

    final finder = Finder(filter: Filter.byKey(user.id));
    final result = await usersFolder
                  .update(await database, user.toJson(),finder: finder);

    return result != null;
  }

  static Future<bool> deleteUser(User user) async {
    final database = await AppDatabase.instance.database;

    final finder = Finder(filter: Filter.byKey(user.id));
    final result = await usersFolder.delete(database, finder: finder);

    return result != null;
  }
}