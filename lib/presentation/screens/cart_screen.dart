import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technaureus_test/presentation/widgets/product_add_cart_button.dart';

import '../../business_logic/bloc/product/product_bloc.dart';
import '../../business_logic/bloc/product/product_event.dart';
import '../../business_logic/bloc/product/product_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => ProductBloc()
        ..add(const CartProducts(add: false, remove: false, delete: false)),
      child: Container(
        width: _width,
        height: _height,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, state) {
            if (state is ProductLoading) {
              return Center(
                  child: Container(
                child: Text("ProductLoading"),
              ));
            } else if (state is CartProductLoaded) {
              return Stack(
                children: [
                  Container(
                    width: _width,
                    height: _height * 0.8,
                    child: ListView.separated(
                      itemCount: state.product.length,
                      padding: const EdgeInsets.only(bottom: 300),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.product[index].name),
                          subtitle:
                              Text("\u20B9 ${state.product[index].price}/-"),
                          trailing: ProductAddCartButton(
                            index: index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                  if (state.product.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Subtotal"),
                                      Text("\u20B9 ${state.subTotal}/-"),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tax"),
                                      Text("\u20B9 50/-"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Total",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "\u20B9 ${state.total}/-",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: _width * 0.35,
                                        height: _height * 0.04,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          color: const Color.fromRGBO(15, 31, 129, 1.0)
                                        ),
                                        child: Center(
                                          child: Text(
                                              "Order",
                                            style: TextStyle(
                                                color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.35,
                                        height: _height * 0.04,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: const Color.fromRGBO(15, 31, 129, 1.0)
                                        ),
                                        child: Center(
                                          child: Text(
                                              "Order & Deliver",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return Center(
                  child: Container(
                child: Text("Error"),
              ));
            }
          },
        ),
      ),
    );
  }
}
