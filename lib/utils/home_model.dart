import 'package:flutter/material.dart';
import 'package:technaureus_test/presentation/custom_paint/icons.dart';

class GridItem {
  final String label;
  final Widget icon;
  final int index;
  const GridItem(
      {required this.label, required this.icon, required this.index});
}

final List<GridItem> gridItem = [
  GridItem(label: "Customers", icon: imageAsset("assets/images/customer.png"), index: 4),
  GridItem(label: "Products", icon: custom(ProductIcon()), index: 5),
  GridItem(label: "New Order", icon: imageAsset("assets/images/new_order.png"), index: 1),
  GridItem(label: "Return Order", icon: imageAsset("assets/images/return_order.png"), index: 3),
  GridItem(label: "Add Payment", icon: imageAsset("assets/images/payment.png"), index: 6),
  GridItem(
      label: "Today's Order",
      icon: imageAsset("assets/images/today_order.png"),
      index: 7),
  GridItem(
      label: "Today's Summery",
      icon: imageAsset("assets/images/today_summery.png"),
      index: 8),
  GridItem(
      label: "Route", icon: imageAsset("assets/images/route.png"), index: 9),
];

Widget custom(CustomPainter child) {
  return Container(
    width: 30,
    height: 40,
    child: CustomPaint(
      painter: child,
    ),
  );
}

Widget paymentIcon(CustomPainter child) {
  return Container(
    width: 40,
    height: 40,
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 30,
            height: 30,
            child: CustomPaint(
              painter: child,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            color: Colors.white,
            padding: EdgeInsets.only(left: 5, top: 5),
            child: CustomPaint(
              painter: child,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget imageAsset(String image) {
  return Image.asset(
    image,
    width: 30,
  );
}
Widget colorFilterAsset(String image) {
  return ColorFiltered(
    colorFilter: ColorFilter.mode(
        Colors.white,
        BlendMode.color,
    ),
    child: Image.asset(
      image,
      width: 30,
    ),
  );
}
