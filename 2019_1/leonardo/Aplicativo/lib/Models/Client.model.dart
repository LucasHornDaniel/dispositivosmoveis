class Client {
  int id;
  String login;
  String password;
  String email;
  String firstName;
  String lastName;
  String phone;
  String administrator;

  Client({this.id, this.login, this.password, this.email, this.firstName, this.lastName, this.phone, this.administrator});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    password = json['password'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    administrator = json['administrator'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['administrator'] = this.administrator;
    return data;
  }
}
