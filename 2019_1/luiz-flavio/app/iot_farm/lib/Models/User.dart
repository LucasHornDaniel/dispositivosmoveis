class User {

  final int code_user;
  final String name;
  final String username;

  User({this.code_user,this.name, this.username});

  User.fromJson(Map<String, dynamic> json)
      : code_user = int.parse(json['code_user']),
        name = json['name'],
        username = json['user'];

  Map<String, dynamic> toJson() =>
      {
        'code_user': code_user,
        'name': name,
        'user': username,
      };
}
