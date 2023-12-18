import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:technaureus_test/data/models/addOrEdit.dart';
import 'package:technaureus_test/data/models/customers_model.dart';
import 'package:technaureus_test/data/repository/customer_repo.dart';
import 'package:technaureus_test/sqflite_db/customer_db/db.dart';
import 'package:technaureus_test/sqflite_db/customer_db/model.dart';

import '../../../data/repository/add_edit_customer.dart';
import '../../../utils/constants.dart';

@immutable
abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class AllCustomers extends CustomerEvent {
  final bool? isAdd;
  final CustomerData? customerData;
  const AllCustomers({this.isAdd, this.customerData}) : super();

  Future<bool?> addOrEditCustomer() async {
    if (isAdd != null) {
      if (isAdd!) {
        print("------Add Customer-----");
        bool add = await  AddOrEditCustomer().addCustomer(
          name: customerData!.name,
          profilePic: customerData!.profilePic,
          mobileNum: customerData!.mobileNum,
          email: customerData!.email,
          street: customerData!.street,
          streetTwo: customerData!.street2,
          city: customerData!.city,
          state: customerData!.state,
          pinCode: customerData!.pinCode,
          country: customerData!.pinCode,
        );
        return add;
      } else {
        print("------Edit Customer-----");
        bool edit = await  AddOrEditCustomer().editCustomer(
          name: customerData!.name,
          profilePic: customerData!.profilePic,
          mobileNum: customerData!.mobileNum,
          email: customerData!.email,
          street: customerData!.street,
          streetTwo: customerData!.street2,
          city: customerData!.city,
          state: customerData!.state,
          pinCode: customerData!.pinCode,
          country: customerData!.pinCode,
        );
        return edit;
      }
    }
    return null;
  }

  Future<List<Customer>?> readAllData() async {
    List<Customer>? customers =
        await CustomerDatabase.instance.readAllProductData();
    return customers;
  }

  Future<void> initialApiCall() async {
    print("----api calling------");
    CustomersRepo repo = CustomersRepo();
    CustomersModel resp = await repo.getCustomers();
    if (resp.error_code == 0 && resp.data.isNotEmpty) {
      for (var customer in resp.data) {
        print("---- fv dfvfdev------${customer.mobile_number}");
        String filePath = "";
        if (customer.profile_pic != "") {
          filePath = await _downloadImage(url: customer.profile_pic);
        }
        Customer data = Customer(
          id: customer.id,
          name: customer.name,
          profilePic: filePath,
          mobileNum: customer.mobile_number,
          email: customer.email,
          street: customer.street,
          streetTwo: customer.street_two,
          city: customer.city,
          pincode: customer.pincode,
          country: customer.country,
          state: customer.state,
          createdDate: customer.created_date,
          createdTime: customer.created_time,
          modifiedDate: customer.modified_date,
          modifiedTime: customer.modified_time,
        );
        await CustomerDatabase.instance.create(data);
      }
    }
  }

  Future<String> _downloadImage({required String url}) async {
    await Permission.storage.request();
    String fileUrl = ApiConstants.downloadUrl + url;
    String filename = url.split("/").last;

    final path = (await getApplicationDocumentsDirectory()).path;
    var dir = Directory('$path/Customers');

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
      var dir = await Directory('$path/Customers').create(recursive: true);
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
}
