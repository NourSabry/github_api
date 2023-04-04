import 'dart:convert';

 class Repo {
  final String name;
  final String desc;
  final String userName;
  Repo({
    required this.name,
    required this.desc,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'desc': desc,
      'userName': userName,
    };
  }

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      name: map['name'] as String,
      desc: map['desc'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Repo.fromJson(String source) => Repo.fromMap(json.decode(source) as Map<String, dynamic>);
}
