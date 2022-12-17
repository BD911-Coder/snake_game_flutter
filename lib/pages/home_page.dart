import 'package:flutter/material.dart';
import 'package:snake_game/widgets/blank_pixel.dart';
import 'package:snake_game/widgets/food_pixel.dart';
import 'package:snake_game/widgets/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //grid builder
  int rowSize = 10;
  int totalNumberOfSquare = 100;

  //snake position
  List<int> snakePosition = [
    0,
    1,
    2,
  ];

  //food

  int foodPosition = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        //high scores
        children: [
          Expanded(
            child: Container(
              child: Container(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: totalNumberOfSquare,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowSize),
                  itemBuilder: ((context, index) {
                    if (snakePosition.contains(index)) {
                      return const SnakePixel();
                    } else if (foodPosition == index) {
                      return const FoodPixel();
                    } else {
                      return const BlankPixel();
                    }
                  })),
            ),
          ),
          Expanded(
            child: Container(
              child: Container(),
            ),
          ),
        ],

        //game grid

        //play button
      ),
    );
  }
}
