class Baby {
  final String name;
  final DateTime birthday;

  Baby({
    this.name,
    this.birthday
  });

  factory Baby.fromJson(dynamic jsonObj) {
    return Baby(
      name: jsonObj['name'],
      birthday: DateTime.fromMillisecondsSinceEpoch(jsonObj['birthday'])
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'birthday': birthday.millisecondsSinceEpoch
  };
}