import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.red,size: 30,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Internet Connection Needed At First Opening Of App After Installation."),
            ),
          ],
        ),
      ),
    );
  }
}
