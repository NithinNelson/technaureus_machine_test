

import 'dart:convert';
import 'package:technaureus_test/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../models/products_model.dart';

class ProductRepo {
  String url = ApiConstants.baseUrl + ApiConstants.getProducts;

  Future<ProductsModel> getProducts() async {
    http.Response resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      ProductsModel products = ProductsModel.fromJson(json.decode(resp.body));
      return products;
    } else {
      throw Exception("domain error");
    }
  }
}