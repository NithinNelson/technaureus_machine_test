import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_state.dart';
import 'package:technaureus_test/data/models/addOrEdit.dart';
import 'package:technaureus_test/presentation/widgets/customer_widget.dart';
import 'package:technaureus_test/sqflite_db/customer_db/model.dart';
import 'package:technaureus_test/utils/snack_bar.dart';

import '../../business_logic/bloc/customers/customer_event.dart';
import '../../business_logic/bloc/product/product_event.dart';
import '../widgets/connection_error.dart';
import '../widgets/loading_screen.dart';

class CustomerScreen extends StatefulWidget {
  final bool customerScreen;
  const CustomerScreen({super.key, required this.customerScreen});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Customer> customers = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _sreetController = TextEditingController();
  TextEditingController _sreet2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  String? _country;
  String? _state;
  List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];


  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerLoaded) {
             if(state.doneAdding != null) {
               if (state.doneAdding!) {
                 showSnackBar(context, "Success", Colors.green);
               } else {
                 showSnackBar(context, "Failed", Colors.red);
               }
             }
          }
        },
        builder: (context, state) {
          if (state is CustomerLoading) {
            return const LoadingScreen();
          } else if (state is CustomerLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CustomerBloc>(context).add(const AllCustomers());
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
                            width: widget.customerScreen ? 80.w : 40.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.qr_code,
                                  color: Colors.grey,
                                ),
                                if (widget.customerScreen)
                                  GestureDetector(
                                    onTap: () {
                                      _showBottomSheet1(context, context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(15, 31, 129, 1.0),
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.customer.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomerWidget(
                            customer: state.customer[index],
                            customerScreen: widget.customerScreen,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CustomerNetworkError) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CustomerBloc>(context).add(const AllCustomers());
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

  void _showBottomSheet1(BuildContext context, BuildContext blocContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showBottomSheet2(context, blocContext, isAdd: true);
                  },
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(15, 31, 129, 1.0)
                    ),
                    child: const Center(
                      child: Text(
                        "Add Customer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showBottomSheet2(context, blocContext, isAdd: false);
                  },
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(15, 31, 129, 1.0)
                    ),
                    child: const Center(
                      child: Text(
                        "Edit Customer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _showBottomSheet2(BuildContext context, BuildContext blocContext, {required bool isAdd}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.width * 1.1) + MediaQuery.of(context).viewInsets.bottom,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isAdd ? "Add Customer" : "Edit Customer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromRGBO(178, 186, 241, 1.0),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.close, size: 14, color: Color.fromRGBO(15, 31, 129, 1.0),),
                            ),
                          ),
                        ],
                      ),
                      Text(
                          "Customer Name",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        child: TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Mobile Number';
                            } else if (value.length < 10 || value.length > 10) {
                              return 'Please enter a valid Mobile Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address.';
                            }
                            const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,5}$';
                            if (!RegExp(emailRegex).hasMatch(value)) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                          "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: TextFormField(
                              controller: _sreetController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "Street",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the field';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: TextFormField(
                              controller: _sreet2Controller,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "Street2",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the field';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: TextFormField(
                              controller: _cityController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "City",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: TextFormField(
                              controller: _pinCodeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Pin code",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.only(top: 5, bottom: 5,  left: 10,  right: 10)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Pin code';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50.h,
                            width: 150.w,
                            child: DropdownButton(
                              value: _country,
                              menuMaxHeight: 400,
                              hint: Text(
                                  "Country",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              underline: Divider(
                                color: Colors.grey,
                              ),
                              style: TextStyle(
                              fontSize: 12,
                                color: Colors.black,
                            ),
                              isExpanded: true,
                              selectedItemBuilder: (context) {
                                return <String>['India', 'United State', 'China']
                                    .map<Widget>((String item) {
                                  return Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              elevation: 0,
                              onChanged: (value) {
                                setState(() => _country = value.toString());
                              },
                              items: <String>['India', 'United State', 'China']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                            width: 150.w,
                            child: DropdownButton(
                              value: _state,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              elevation: 0,
                              menuMaxHeight: 400,
                              hint: Text(
                                "State",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              underline: Divider(
                                color: Colors.grey,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              selectedItemBuilder: (context) {
                                return states.map<Widget>((String item) {
                                  return Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onChanged: (value) {
                                setState(() => _state = value.toString());
                              },
                              items: states.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_nameController.text.isNotEmpty &&
                                  _mobileController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _sreetController.text.isNotEmpty &&
                              _sreet2Controller.text.isNotEmpty &&
                              _cityController.text.isNotEmpty &&
                              _pinCodeController.text.isNotEmpty &&
                              _country != null && _state != null) {
                                CustomerData customer = CustomerData(
                                  name: _nameController.text,
                                  mobileNum: _mobileController.text,
                                  email: _emailController.text,
                                  street: _sreetController.text,
                                  street2: _sreet2Controller.text,
                                  city: _cityController.text,
                                  pinCode: _pinCodeController.text,
                                  country: _country,
                                  state: _state,
                                );
                                BlocProvider.of<CustomerBloc>(blocContext).add(
                                  AllCustomers(
                                    isAdd: isAdd,
                                    customerData: customer,
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                showSnackBar(context, "Please fill all fields", Colors.red);
                              }
                            },
                            child: Container(
                              width: 100.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color.fromRGBO(15, 31, 129, 1.0)
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
    );
  }
}
