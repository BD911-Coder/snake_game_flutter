import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/widgets/blank_pixel.dart';
import 'package:snake_game/widgets/food_pixel.dart';
import 'package:snake_game/widgets/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum SnakeDirection { UP, DOWN, RIGHT, LEFT }

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

  //initial snake direction

  var currentDirection = SnakeDirection.RIGHT;

  //score
  int currentScore = 0;

  //food

  int foodPosition = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 &&
                    currentDirection != SnakeDirection.UP) {
                  currentDirection = SnakeDirection.DOWN;
                } else if (details.delta.dy < 0 &&
                    currentDirection != SnakeDirection.DOWN) {
                  currentDirection = SnakeDirection.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    currentDirection != SnakeDirection.LEFT) {
                  currentDirection = SnakeDirection.RIGHT;
                } else if (details.delta.dx < 0 &&
                    currentDirection != SnakeDirection.RIGHT) {
                  currentDirection = SnakeDirection.LEFT;
                }
              },
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
              child: Center(
                child:
                    TextButton(onPressed: startGame, child: const Text('PLAY')),
              ),
            ),
          ),
        ],

        //game grid

        //play button
      ),
    );
  }

  void startGame() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        //move physics
        moveSnake();
        if (gameOver()) {
          timer.cancel();
          //message display
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Game Over!'),
                  content: Text('Your Score is: $currentScore.toStrong()'),
                );
              });
        }
      });
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.DOWN:
        {
          //add head
          if (snakePosition.last + rowSize > totalNumberOfSquare) {
            snakePosition
                .add(snakePosition.last + rowSize - totalNumberOfSquare);
          } else {
            snakePosition.add(snakePosition.last + rowSize);
          }
        }

        break;
      case SnakeDirection.UP:
        {
          //add head
          if (snakePosition.last < rowSize) {
            snakePosition
                .add(snakePosition.last - rowSize + totalNumberOfSquare);
          } else {
            snakePosition.add(snakePosition.last - rowSize);
          }
        }
        break;
      case SnakeDirection.RIGHT:
        {
          //add head
          // re-position
          if (snakePosition.last % rowSize == 9) {
            snakePosition.add(snakePosition.last + 1 - rowSize);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
        }
        break;
      case SnakeDirection.LEFT:
        {
          //add head
          // re-position
          if (snakePosition.last % rowSize == 0) {
            snakePosition.add(snakePosition.last - 1 + rowSize);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
        }
        break;
      default:
    }
    //food physics
    if (snakePosition.last == foodPosition) {
      eatFood();
    } else {
      snakePosition.removeAt(0);
    }
  }

  void eatFood() {
    currentScore++;
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberOfSquare);
    }
  }

  bool gameOver() {
    List<int> bodySnake = snakePosition.sublist(0, snakePosition.length - 1);

    if (bodySnake.contains(snakePosition.last)) {
      return true;
    } else {
      return false;
    }
  }
}
