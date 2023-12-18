

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_event.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_state.dart';
import 'package:technaureus_test/sqflite_db/customer_db/db.dart';

import '../../../sqflite_db/customer_db/model.dart';
import '../../../utils/check_connectivity.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerLoading()) {
    on<AllCustomers>(_getAllCustomers);
  }
  
  void _getAllCustomers(AllCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      List<Customer>? customers = await event.readAllData();
      bool connection = await CheckConnectivity().check();
      if (connection) {
        if (customers != null) {
          await CustomerDatabase.instance.deleteTable();
        }
        bool? isDone = await event.addOrEditCustomer();
        await event.initialApiCall();

        List<Customer>? updatedCustomers = await event.readAllData();
        emit(CustomerLoaded(customer: updatedCustomers!, doneAdding: isDone));
      } else {
        if (customers!.isNotEmpty) {
          emit(CustomerLoaded(customer: customers));
        } else {
          emit(CustomerNetworkError());
        }
      }
    } catch(e) {
      print(e.toString());
      emit(CustomerError());
    }
  }
}