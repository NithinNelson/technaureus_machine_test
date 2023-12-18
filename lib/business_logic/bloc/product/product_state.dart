import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../sqflite_db/product_db/model.dart';


@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;
  const ProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductLoadedFromDb extends ProductState {
  final List<Product> product;
  const ProductLoadedFromDb({required this.product});

  @override
  List<Object> get props => [product];
}

class CartProductLoaded extends ProductState {
  final List<Product> product;
  final int total;
  final int subTotal;
  const CartProductLoaded({required this.total, required this.subTotal, required this.product});

  @override
  List<Object> get props => [product, total, subTotal];
}

class ProductNetworkError extends ProductState {}

class ProductError extends ProductState {

  @override
  List<Object> get props => [];
}