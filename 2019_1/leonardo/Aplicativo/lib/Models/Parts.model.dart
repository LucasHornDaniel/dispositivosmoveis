class Parts {
  int id;
  String model;
  String brand;
  String description;

  Parts({this.id, this.model, this.brand, this.description});

  Parts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    brand = json['brand'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    data['brand'] = this.brand;
    data['description'] = this.description;
    return data;
  }
}