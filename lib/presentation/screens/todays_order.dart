import 'package:flutter/material.dart';


class TodaysOrder extends StatefulWidget {
  const TodaysOrder({super.key});

  @override
  State<TodaysOrder> createState() => _TodaysOrderState();
}

class _TodaysOrderState extends State<TodaysOrder> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: Center(child: Text("TodaysOrder")),
    );
  }
}
