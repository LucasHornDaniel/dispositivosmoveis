class Service {
  int id;
  String type;
  String description;

  Service({this.id, this.type, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}