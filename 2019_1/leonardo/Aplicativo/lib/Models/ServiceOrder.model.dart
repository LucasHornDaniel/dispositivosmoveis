import 'User.model.dart';
import 'Client.model.dart';
import 'Parts.model.dart';
import 'Service.model.dart';
class ServiceOrder {
  int id;
  String status;
  String requestDate;
  String product;
  String problemDescription;
  String solutionDescription;
  String solutionPrice;
  String createdAt;
  String updatedAt;
  int employeeId;
  int clientId;
  Employee employee;
  Client client;
  List<Parts> parts;
  List<Service> services;

  ServiceOrder({this.id, this.status, this.requestDate, this.product, this.problemDescription, this.solutionDescription, this.solutionPrice, this.createdAt, this.updatedAt, this.employeeId, this.clientId, this.employee, this.client, this.parts, this.services});


  getDataFormatada(){
    var aux = this.requestDate.split(" ")[0].split("-");
    return aux[2] + "/" + aux[1] + "/" + aux[0];
  }
  getProductsAsString(){
    String partsString = "";
    parts.forEach((Parts part) {
      partsString += part.model.toString().trim() + "\n";
    });
    return partsString;
  }

  getServicesAsString(){
    String servicesString = "";
    services.forEach((Service service) {
      servicesString += service.type.toString().trim() + "\n";
    });
    return servicesString;
  }


  ServiceOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    requestDate = json['requestDate'];
    product = json['product'];
    problemDescription = json['problemDescription'];
    solutionDescription = json['solutionDescription'].toString();
    solutionPrice = json['solutionPrice'].toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    employeeId = json['employeeId'];
    clientId = json['clientId'];
    employee = json['employee'] != null ? new Employee.fromJson(json['employee']) : null;
    client = json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['parts'] != null) {
      parts = new List<Parts>();
      json['parts'].forEach((v) {
        parts.add(new Parts.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = new List<Service>();
      json['services'].forEach((v) {
        services.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['requestDate'] = this.requestDate;
    data['product'] = this.product;
    data['problemDescription'] = this.problemDescription;
    data['solutionDescription'] = this.solutionDescription;
    data['solutionPrice'] = this.solutionPrice;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['employeeId'] = this.employeeId;
    data['clientId'] = this.clientId;
    if (this.employee != null) {
      data['employee'] = this.employee.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    if (this.parts != null) {
      data['parts'] = this.parts.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
