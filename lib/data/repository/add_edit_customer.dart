

import 'dart:convert';
import 'package:technaureus_test/data/models/customers_model.dart';
import 'package:technaureus_test/utils/constants.dart';
import 'package:http/http.dart' as http;

class AddOrEditCustomer {
  String url = ApiConstants.baseUrl + ApiConstants.getCustomers;

  Future<dynamic> addCustomer({
    String? name,
    String? profilePic,
    String? mobileNum,
    String? email,
    String? street,
    String? streetTwo,
    String? city,
    String? pinCode,
    String? country,
    String? state,
  }) async {

    Map<String, dynamic> _apiBody = {
      "name": name,
      "profile_pic": profilePic,
      "mobile_number": mobileNum,
      "email": email,
      "street": street,
      "street_two": streetTwo,
      "city": city,
      "pincode": pinCode,
      "country": country,
      "state": state
    };

    http.Response resp = await http.post(Uri.parse(url), body: json.encode(_apiBody));
    if (resp.statusCode == 200 && json.decode(resp.body)['message'] == "success") {
      return true;
    } else {
      // throw Exception("domain error");
      return false;
    }
  }

  Future<dynamic> editCustomer({
    String? name,
    String? profilePic,
    String? mobileNum,
    String? email,
    String? street,
    String? streetTwo,
    String? city,
    String? pinCode,
    String? country,
    String? state,
  }) async {

    Map<String, dynamic> _apiBody = {
      "name": name,
      "profile_pic": profilePic,
      "mobile_number": mobileNum,
      "email": email,
      "street": street,
      "street_two": streetTwo,
      "city": city,
      "pincode": pinCode,
      "country": country,
      "state": state
    };

    http.Response resp = await http.put(Uri.parse(url), body: json.encode(_apiBody));
    if (resp.statusCode == 200 && json.decode(resp.body)['message'] == "success") {
      return true;
    } else {
      // throw Exception("domain error");
      return false;
    }
  }
}