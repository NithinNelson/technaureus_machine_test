
import 'package:flutter/material.dart';
import 'package:technaureus_test/utils/home_model.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) updatePage;
  const HomeScreen({super.key, required this.updatePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width,
      height: _height,
      child: GridView.builder(
        itemCount: gridItem.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.updatePage(gridItem[index].index);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: gridItem[index].label == "Products" ? const Color.fromRGBO(15, 31, 129, 1.0) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 3
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gridItem[index].icon,
                  Text(
                      gridItem[index].label,
                    style: TextStyle(
                      color:  gridItem[index].label == "Products" ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
