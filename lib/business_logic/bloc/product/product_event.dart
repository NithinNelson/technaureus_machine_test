import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:technaureus_test/sqflite_db/product_db/db.dart';
import 'package:technaureus_test/sqflite_db/product_db/model.dart';
import 'package:technaureus_test/utils/constants.dart';

import '../../../data/models/products_model.dart';
import '../../../data/repository/product_repo.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// class ProductsInCart extends ProductEvent {}

class AllProducts extends ProductEvent {
  const AllProducts() : super();

  Future<void> initialApiCall() async {
    print("----api calling------");
    ProductRepo repo = ProductRepo();
    ProductsModel resp = await repo.getProducts();
    if (resp.error_code == 0 && resp.data.isNotEmpty) {
      for (var product in resp.data) {
       String filePath = await _downloadImage(url: product.image);
       Product prod = Product(
            id: product.id,
            name: product.name,
            image: filePath,
            price: product.price,
            inCartCount: 0);
       await ProductDatabase.instance.create(prod);
      }
    }
  }

  Future<void> updateApi(List<Product> dbProduct) async {

    print("----api updating------");
    ProductRepo repo = ProductRepo();
    ProductsModel resp = await repo.getProducts();
    if (resp.error_code == 0 && resp.data.isNotEmpty) {
      bool create = false;
      Product? prod;

      for (var product in resp.data) {
        for (var dbprod in dbProduct) {
          if (product.id != dbprod.id &&
              product.name != dbprod.name &&
              product.price != dbprod.price) {
            String filePath = await _downloadImage(url: product.image);
            create = true;
            prod = Product(
                id: product.id,
                name: product.name,
                image: filePath,
                price: product.price,
                inCartCount: 0);
          } else {
            create = false;
            break;
          }
        }

        if (create) {
          await ProductDatabase.instance.create(prod!);
        }
      }
    }
  }

  Future<String> _downloadImage({required String url}) async {
    await Permission.storage.request();
    String fileUrl = ApiConstants.downloadUrl + url;
    String filename = url.split("/").last;


    final path = (await getApplicationDocumentsDirectory()).path;
    var dir = Directory('$path/Products');

    if (dir.existsSync()) {
      var files = dir.listSync();
      for (var file in files) {
        if ((file.path.split('/').last == filename)) {
          return file.path;
        }
      }
    }

    var file = File('/');
    if (await dir.exists()) {
      file = File('${dir.path}/$filename');
    } else {
      var dir = await Directory('$path/Products').create(recursive: true);
      file = File('${dir.path}/$filename');
    }

    try {
      Dio dio = Dio();
      await dio.download(fileUrl, '${dir.path}/$filename');
      return file.path;
    } catch (e) {
      return "";
    }
  }

  Future<List<Product>?> readAllData() async {
    List<Product>? products = await ProductDatabase.instance.readAllProductData();
    return products;
  }
}

class GetProductFromDb extends ProductEvent {
  final Product? product;
  final bool add;
  final bool remove;
  final bool delete;
  const GetProductFromDb({required this.add, required this.remove, required this.delete, this.product}) : super();


  Future<List<Product>?> readAllData() async {
    List<Product>? products = await ProductDatabase.instance.readAllProductData();
    return products;
  }

  Future<void> addProduct() async {
    if (product != null && add) {
      Product prod = Product(
          id: product!.id,
          name: product!.name,
          image: product!.image,
          price: product!.price,
          inCartCount: product!.inCartCount + 1,
      );

      await ProductDatabase.instance.update(prod);
    }
  }

  Future<void> removeProduct() async {
    if (product != null && remove) {
      Product prod = Product(
        id: product!.id,
        name: product!.name,
        image: product!.image,
        price: product!.price,
        inCartCount: product!.inCartCount - 1,
      );

      await ProductDatabase.instance.update(prod);
    }
  }

  Future<void> deleteProduct() async {
    if (product != null && delete) {
      Product prod = Product(
        id: product!.id,
        name: product!.name,
        image: product!.image,
        price: product!.price,
        inCartCount: 0,
      );

      await ProductDatabase.instance.update(prod);
    }
  }
}

class CartProducts extends ProductEvent {
  final Product? product;
  final bool add;
  final bool remove;
  final bool delete;
  const CartProducts({required this.add, required this.remove, required this.delete, this.product}) : super();

  Future<List<Product>?> readAllCartProducts() async {
    List<Product>? products = await ProductDatabase.instance.readAllProductData();
    List<Product>? modifiedProd = [];

    products!.forEach((element) {
      if (element.inCartCount != 0) {
        modifiedProd.add(element);
      }
    });
    return modifiedProd;
  }

  int calculateSubTotal({required List<Product>? products}) {
    int subTotal = 0;
    products!.forEach((element) {
      subTotal += element.price * element.inCartCount;
    });
    return subTotal;
  }

  int calculateTotal({required int subTotal}) {

    return subTotal + 50;
  }

  Future<void> addProduct() async {
    if (product != null && add) {
      Product prod = Product(
        id: product!.id,
        name: product!.name,
        image: product!.image,
        price: product!.price,
        inCartCount: product!.inCartCount + 1,
      );

      await ProductDatabase.instance.update(prod);
    }
  }

  Future<void> removeProduct() async {
    if (product != null && remove) {
      Product prod = Product(
        id: product!.id,
        name: product!.name,
        image: product!.image,
        price: product!.price,
        inCartCount: product!.inCartCount - 1,
      );

      await ProductDatabase.instance.update(prod);
    }
  }

  Future<void> deleteProduct() async {
    if (product != null && delete) {
      Product prod = Product(
        id: product!.id,
        name: product!.name,
        image: product!.image,
        price: product!.price,
        inCartCount: 0,
      );

      await ProductDatabase.instance.update(prod);
    }
  }
}
