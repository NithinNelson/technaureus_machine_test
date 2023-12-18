import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/bloc/product/product_bloc.dart';
import '../../business_logic/bloc/product/product_event.dart';
import '../../business_logic/bloc/product/product_state.dart';

class ProductAddCartButton extends StatelessWidget {
  final int index;
  const ProductAddCartButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, state) {
        if (state is ProductLoading) {
          return Container(
            width: 45.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(15, 31, 129, 1.0),
              borderRadius: BorderRadius.circular(5),
            ),
          );
        } else if (state is CartProductLoaded) {
          return Container(
            height: 20.h,
            width: 75.w,
            child: Row(
              children: [
                Container(
                  width: 45.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(15, 31, 129, 1.0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            if (state.product[index].inCartCount != 1) {
                              BlocProvider.of<ProductBloc>(context).add(
                                CartProducts(
                                  product: state.product[index],
                                  add: false,
                                  delete: false,
                                  remove: true,
                                ),
                              );
                            } else {
                              BlocProvider.of<ProductBloc>(context).add(
                                CartProducts(
                                  product: state.product[index],
                                  add: false,
                                  delete: true,
                                  remove: false,
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 15.w,
                            height: 20.h,
                            child: const Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 15.w,
                          height: 20.h,
                          child: Center(
                            child: Text(
                              state.product[index].inCartCount.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<ProductBloc>(context).add(
                              CartProducts(
                                product: state.product[index],
                                add: true,
                                delete: false,
                                remove: false,
                              ),
                            );
                          },
                          child: Container(
                            width: 15.w,
                            height: 20.h,
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductBloc>(context).add(
                        CartProducts(
                          product: state.product[index],
                          add: false,
                          delete: true,
                          remove: false,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //   ),
                // )
              ],
            ),
          );
        } else {
          return Container(
            width: 45.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(15, 31, 129, 1.0),
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }
      },
    );
  }
}
