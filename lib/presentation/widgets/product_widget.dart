import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technaureus_test/presentation/widgets/product_add_button.dart';

import '../../business_logic/bloc/product/product_bloc.dart';
import '../../business_logic/bloc/product/product_event.dart';
import '../../sqflite_db/product_db/model.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final int index;
  const ProductWidget({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(product.image),
              height: 80.h,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "\u20B9 ${product.price}/-",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 1,
                    height: 13,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black26,
                            Colors.black12
                          ], // Replace with your desired gradient colors
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                        )),
                  ),
                  Container(
                    width: 1,
                    height: 13,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black26,
                            Colors.black12
                          ], // Replace with your desired gradient colors
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        )),
                  ),
                ],
              ),
              BlocProvider(
                create: (_) => ProductBloc()
                  ..add(const GetProductFromDb(
                      add: false, remove: false, delete: false)),
                child: ProductAddButton(index: index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
