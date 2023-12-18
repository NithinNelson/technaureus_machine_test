import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/product/product_bloc.dart';
import 'package:technaureus_test/presentation/screens/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
          BlocProvider<CustomerBloc>(create: (context) => CustomerBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MenuPage(),
        ),
      ),
    );
  }
}
