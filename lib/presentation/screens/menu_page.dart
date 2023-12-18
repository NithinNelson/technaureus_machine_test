import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_bloc.dart';
import 'package:technaureus_test/business_logic/bloc/customers/customer_event.dart';
import 'package:technaureus_test/presentation/custom_paint/menu_icon.dart';
import 'package:technaureus_test/presentation/screens/cart_screen.dart';
import 'package:technaureus_test/presentation/screens/home_screen.dart';
import 'package:technaureus_test/presentation/screens/new_order_screen.dart';
import 'package:technaureus_test/presentation/screens/payment_screen.dart';
import 'package:technaureus_test/presentation/screens/product_screen.dart';
import 'package:technaureus_test/presentation/screens/return_order.dart';
import 'package:technaureus_test/presentation/screens/rounte_screen.dart';
import 'package:technaureus_test/presentation/screens/todays_order.dart';
import 'package:technaureus_test/presentation/screens/todays_summery.dart';

import '../../business_logic/bloc/product/product_bloc.dart';
import '../../business_logic/bloc/product/product_event.dart';
import 'customer_screen.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0;
  List<Widget>? screens;

  final title = [
    "",
    "New Order",
    "Your Cart",
    "",
    "Customers",
    "Nesto Hypermarket",
    "Add Payment",
    "Today's Order",
    "Today's Summery",
    "Route",
  ];

  switchPage(int index) {
    currentIndex = index;
  }

  @override
  void didChangeDependencies() {
    screens = [
      HomeScreen(updatePage: (int index) => setState(() =>  currentIndex = index)),
      const CustomerScreen(customerScreen: false),
      const CartScreen(),
      const ReturnOrder(),
      const CustomerScreen(customerScreen: true),
      const ProductScreen(),
      const PaymentScreen(),
      const TodaysOrder(),
      const TodaysSummery(),
      const RouteScreen(),
    ];
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MenuPage oldWidget) {
    screens = [
      HomeScreen(updatePage: (int index) => setState(() =>  currentIndex = index)),
      const CustomerScreen(customerScreen: false),
      const CartScreen(),
      const ReturnOrder(),
      const CustomerScreen(customerScreen: true),
      const ProductScreen(),
      const PaymentScreen(),
      const TodaysOrder(),
      const TodaysSummery(),
      const RouteScreen(),
    ];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            title[currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: currentIndex == 0
            ? Icon(Icons.person)
            : InkWell(
          onTap: () {
            setState(() {
              currentIndex = 0;
            });
          },
            child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 20,
              height: 20,
              child: CustomPaint(
                painter: MenuIcon(),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 18.0,
              // offset: Offset(0, 2)
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex > 4 ? 0 : currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromRGBO(15, 31, 129, 1.0),
            onTap: (index) => setState(() => currentIndex = index),
            unselectedLabelStyle: TextStyle(
              color: const Color.fromRGBO(15, 31, 129, 1.0),
              fontSize: 12,
            ),
            selectedLabelStyle: TextStyle(
              color: const Color.fromRGBO(15, 31, 129, 1.0),
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: const Color.fromRGBO(15, 31, 129, 1.0),),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/new_order.png",
                  width: 25,
                ),
                label: "New Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined, color: const Color.fromRGBO(15, 31, 129, 1.0),),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/return_order.png",
                  width: 25,
                ),
                label: "Return Order",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/customer2.png",
                  width: 25,
                ),
                label: "Customers",
              ),
            ],
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductBloc()..add(const AllProducts())),
          BlocProvider(create: (_) => CustomerBloc()..add(const AllCustomers())),
        ],
          child: screens![currentIndex]),
    );
  }
}
