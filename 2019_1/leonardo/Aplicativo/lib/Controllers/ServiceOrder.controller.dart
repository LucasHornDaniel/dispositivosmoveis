import 'package:dio/dio.dart';
import '../Models/ServiceOrder.model.dart';
import '../Data/shared_prefs.dart';

class ServiceOrderController {
  SharedPrefs prefs = new SharedPrefs();
  Dio dio = new Dio();

  Future<List<ServiceOrder>> getServiceOrders() async {
    List<ServiceOrder> serviceOrders = [];
    final String baseUrl = await prefs.getBaseUrl();
    final String token = await prefs.getToken();
    final String userId = await prefs.getUserId();
    Response response = await dio.get(baseUrl + '/serviceorder/user/' + userId, options: new Options(headers: {"Authorization": token}));
    if (response.statusCode == 200) {
      response.data.map((i) => {serviceOrders.add(ServiceOrder.fromJson(i))}).toList();
    }
    return serviceOrders;
  }


  Future<bool> updateServiceOrderStatus(String id) async {
    final String baseUrl = await prefs.getBaseUrl();
    final String token = await prefs.getToken();
    String body = '{"id": ' + id + ',"status": "Aguardando Técnico"}';

    Response response = await dio.put(baseUrl + '/serviceorder', options: new Options(headers: {"Authorization": token}), data: body);
    if (response.statusCode == 201) {
      return true;
    }
    return false;


  }
}
