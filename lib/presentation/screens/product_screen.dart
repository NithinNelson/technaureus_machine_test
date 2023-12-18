import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technaureus_test/business_logic/bloc/product/product_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/product/product_state.dart';
import 'package:technaureus_test/presentation/widgets/product_widget.dart';
import 'package:technaureus_test/presentation/widgets/product_add_button.dart';

import '../../business_logic/bloc/product/product_event.dart';
import '../widgets/connection_error.dart';
import '../widgets/loading_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, state) {
          if (state is ProductLoading) {
            return const LoadingScreen();
          } else if (state is ProductNetworkError) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ProductBloc>(context).add(const AllProducts());
              },
                child: ListView(
                  children: [
                    Container(
                      width: _width,
                        height: _height * 0.8,
                        child: const ConnectionError(),
                    ),
                  ],
                ),
            );
          } else if (state is ProductLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ProductBloc>(context).add(const AllProducts());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 8, bottom: 8),
                    child: Container(
                      width: _width,
                      height: 45,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintText: "Search",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          suffixIcon: Container(
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.qr_code,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.grey,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "Fruits",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.product.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                            childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        return ProductWidget(
                          product: state.product[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Container(
              child: Text("Error"),
            ));
          }
        },
      ),
    );
  }
}
