
import 'package:flutter/material.dart';


class TodaysSummery extends StatefulWidget {
  const TodaysSummery({super.key});

  @override
  State<TodaysSummery> createState() => _TodaysSummeryState();
}

class _TodaysSummeryState extends State<TodaysSummery> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: Center(child: Text("TodaysSummery")),
    );
  }
}
