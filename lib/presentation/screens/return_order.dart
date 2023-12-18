import 'package:flutter/material.dart';


class ReturnOrder extends StatefulWidget {
  const ReturnOrder({super.key});

  @override
  State<ReturnOrder> createState() => _ReturnOrderState();
}

class _ReturnOrderState extends State<ReturnOrder> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: Center(child: Text("Return Order")),
    );
  }
}
