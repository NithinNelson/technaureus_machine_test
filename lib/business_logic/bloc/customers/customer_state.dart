

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:technaureus_test/sqflite_db/customer_db/model.dart';

@immutable
abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customer;
  final bool? doneAdding;
  const CustomerLoaded({required this.customer, this.doneAdding});

  @override
  List<Object> get props => [customer, doneAdding!];
}

class CustomerError extends CustomerState {}

class CustomerNetworkError extends CustomerState {}