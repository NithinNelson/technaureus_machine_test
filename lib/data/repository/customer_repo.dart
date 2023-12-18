

import 'dart:convert';
import 'package:technaureus_test/data/models/customers_model.dart';
import 'package:technaureus_test/utils/constants.dart';
import 'package:http/http.dart' as http;

class CustomersRepo {
  String url = ApiConstants.baseUrl + ApiConstants.getCustomers;

  Future<CustomersModel> getCustomers() async {
    http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      CustomersModel customers = CustomersModel.fromJson(json.decode(resp.body));
      return customers;
    } else {
      throw Exception("domain error");
    }
  }
}