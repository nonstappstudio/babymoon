import 'baby.dart';

class User {

  final int id;
  bool notificationsEnabled;
  bool isPremium;
  int cashCount;
  Baby baby;

  User({
    this.id,
    this.notificationsEnabled,
    this.isPremium,
    this.cashCount,
    this.baby
  });

  factory User.fromJson(dynamic jsonObj) {
    return User(
      id: jsonObj['id'],
      notificationsEnabled: jsonObj['notificationsEnabled'],
      isPremium: jsonObj['isPremium'],
      cashCount: jsonObj['cashCount'],
      baby: Baby.fromJson(jsonObj['baby'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'notificationsEnabled': notificationsEnabled,
    'isPremium': isPremium,
    'cashCount': cashCount,
    'baby': baby.toJson()
  };

}