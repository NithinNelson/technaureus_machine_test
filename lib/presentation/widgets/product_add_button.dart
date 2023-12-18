import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/bloc/product/product_bloc.dart';
import '../../business_logic/bloc/product/product_event.dart';
import '../../business_logic/bloc/product/product_state.dart';

class ProductAddButton extends StatelessWidget {
  final int index;
  const ProductAddButton({super.key, required this.index});

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
        } else if (state is ProductLoadedFromDb) {
          return Container(
            width: 45.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(15, 31, 129, 1.0),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: state.product[index].inCartCount == 0
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<ProductBloc>(context).add(
                          GetProductFromDb(
                            product: state.product[index],
                            add: true,
                            delete: false,
                            remove: false,
                          ),
                        );
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<ProductBloc>(context).add(
                              GetProductFromDb(
                                product: state.product[index],
                                add: false,
                                delete: false,
                                remove: true,
                              ),
                            );
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<ProductBloc>(context).add(
                              GetProductFromDb(
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
