

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/product/product_event.dart';
import 'package:technaureus_test/business_logic/bloc/product/product_state.dart';
import 'package:technaureus_test/utils/check_connectivity.dart';
import '../../../sqflite_db/product_db/model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<AllProducts>(_getAllProducts);
    on<GetProductFromDb>(_getProductFromDb);
    on<CartProducts>(_getProductForCart);
  }

  void _getAllProducts(AllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      List<Product>? products = await event.readAllData();
      bool connection = await CheckConnectivity().check();
      if (connection) {
        if (products!.isNotEmpty) {
          await event.updateApi(products);
          List<Product>? updatedProducts = await event.readAllData();
          print("$updatedProducts");
          emit(ProductLoaded(product: updatedProducts!));
        } else {
          await event.initialApiCall();
          List<Product>? updatedProducts = await event.readAllData();
          emit(ProductLoaded(product: updatedProducts!));
        }
      } else {
        if (products!.isNotEmpty) {
          emit(ProductLoaded(product: products));
        } else {
          emit(ProductNetworkError());
        }
      }
    } catch(e) {
      print(e.toString());
      emit(ProductError());
    }
  }

  void _getProductFromDb(GetProductFromDb event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await event.addProduct();

      await event.removeProduct();

      await event.deleteProduct();

      List<Product>? products = await event.readAllData();

      emit(ProductLoadedFromDb(product: products!));
    } catch(e) {
      emit(ProductError());
    }
  }

  void _getProductForCart(CartProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await event.addProduct();

      await event.removeProduct();

      await event.deleteProduct();

      List<Product>? products = await event.readAllCartProducts();

      int sub = event.calculateSubTotal(products: products);

      int total = event.calculateTotal(subTotal: sub);

      emit(CartProductLoaded(product: products!, total: total, subTotal: sub));
    } catch(e) {
      emit(ProductError());
    }
  }
}