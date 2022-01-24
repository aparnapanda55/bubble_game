import 'dart:async';
import 'package:bubble_trouble/ball.dart';
import 'package:bubble_trouble/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player.dart';
import 'misile.dart';

enum Direction {
  left,
  right,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//x-corrdinate of player(blue)....
  double xCordPlayer = 0.0;
//........-------..............

//misile variable
  double misileX = 0.0;
  double misileY = 1.0;
  double misileHeight = 0.0;
  // bool midShot = false;
//........-------..............

//function for player to move left.....
  void moveLeft() {
    setState(() {
      //if player goes out of screen then, stop.
      if (xCordPlayer <= -0.9) {
        xCordPlayer = -0.9;
      } else {
        xCordPlayer -= 0.1;
      }

      // if (!midShot) {
      misileX = xCordPlayer;
      // }
    });
  }
//........-------..............

//function for player to move right.....
  void moveRight() {
    setState(() {
      //if player goes out of screen then, stop.
      if (xCordPlayer >= 0.9) {
        xCordPlayer = 0.9;
      } else {
        xCordPlayer += 0.1;
      }

      // if (!midShot) {
      misileX = xCordPlayer;
      // }
    });
  }
//........-------..............

//reset misile to default position......
  void resetMisile() {
    misileX = xCordPlayer;
    misileHeight = 10;
  }
//........-------..............

//function to throw misile.....
  void fireMisile() {
    //if (midShot == false) {
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      //  midShot = true;
      //increase the height of the misile
      setState(() {
        misileHeight += 10;
      });
      //if misile goes out of screen reset the misile.....
      if (misileHeight > MediaQuery.of(context).size.height * 3 / 4) {
        resetMisile();
        timer.cancel();
        //midShot = false;
      }
      //Check if misile has hit the ball
      // if (ballY > heightToCoord(misileHeight) &&
      //     (ballX - misileX).abs() < 0.1) {
      //   score++;
      // }
      if ((ballX - misileX).abs() < 0.05 &&
          ballY > heightToCoord(misileHeight)) {
        score++;
        if (e > 5) {
          e = 0;
        } else {
          e++;
        }
      }
    });
  }

  //}
//........-------..............
//Score variable..
  int score = 0;

//ball Color
  List<Color> colorBall = [
    Colors.teal,
    Colors.red,
    Colors.lightBlue,
    Colors.black,
    Colors.orange,
    Colors.pink,
    Colors.green
  ];
//colorVariable
  int e = 0;
//Ball variables
  double ballX = 0.5;
  double ballY = 0;
  var ballDirection = Direction.left;
//........-------..............

//Start the game by moving the ball...
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      //if ball hits left of screen it changes its direction to right
      if (ballX - 0.01 < -1) {
        ballDirection = Direction.right;
        //if it hits left of screen it changes to right.
      } else if (ballX + 0.01 > 1) {
        ballDirection = Direction.left;
      }
      //if ball direction is left decrease its coordinate by 0.02
      if (ballDirection == Direction.left) {
        setState(() {
          ballX -= 0.02;
        });
        //if ball direction is right increase its coordinate by 0.02
      } else if (ballDirection == Direction.right) {
        setState(() {
          ballX += 0.02;
        });
      }
    });
  }
//........-------..............

//Convert the height of the misile to coordinate using formula..
  double heightToCoord(double height) {
    final totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double missileY = 1 - 2 * (height / totalHeight);
    return missileY;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      //KeyBoard events enabled.......
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMisile();
        }
      },
      child: Column(
        children: [
          Expanded(
            //upper half of the screen which is 3/4th of the screen.....
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Card(
                        color: Colors.blueGrey[200],
                        elevation: 10,
                        child: Text(
                          'Score: $score',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // MyBall(
                    //   ballX: ballX,
                    //   ballY: ballY,
                    //   colorBall: colorBall[e],
                    // ),
                    //missile with its heigth increasing on tap and coordinate matches with the player coordinate....
                    // Misile(
                    //     misileX: misileX,
                    //     misileY: misileY,
                    //     misileHeight: misileHeight),
                    //my player for the moving player with its x-coordinate increasing or decreasing......
                    // MyPlayer(
                    //   xCord: xCordPlayer,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          //lower half of the screen is 1/4th of the screen.....
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //buttons with ontap function to move the player and the misile.
                      // MyButton(
                      //   icon: Icons.arrow_back_ios_new_rounded,
                      //   function: moveLeft,
                      // ),
                      // MyButton(
                      //   icon: Icons.arrow_upward_rounded,
                      //   function: fireMisile,
                      // ),
                      // MyButton(
                      //   icon: Icons.arrow_forward_ios_rounded,
                      //   function: moveRight,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // MyButton(
                  //   icon: Icons.play_arrow,
                  //   function: startGame,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final AnimationController ballController;
  late final Animation<double> ballAnimation;

  late final AnimationController missileController;
  late final Animation<double> missileAnimation;

  int score = 0;
  double playerLeft = 0;
  double ballBottom = 0;
  double ballLeft = 0;
  double missileLeft = 0;
  double missileBottom = 0;

  @override
  void initState() {
    super.initState();
    ballController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            ballController.repeat(reverse: true);
          }
        },
      );
    ballAnimation = Tween<double>(begin: 0, end: 1).animate(ballController);
    ballController.forward();

    missileController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          missileController.reset();
        }
      })
      ..addListener(() {
        if ((missileBottom > ballBottom - 10 &&
                missileBottom < ballBottom + 30) &&
            (missileLeft > ballLeft - 10 && missileLeft < ballLeft + 30)) {
          print('hit');
          setState(() {
            score++;
          });
        }
      });
    missileAnimation =
        Tween<double>(begin: 0, end: 1).animate(missileController);
  }

  @override
  void dispose() {
    ballController.dispose();
    missileController.dispose();
    super.dispose();
  }

  _moveLeft() {
    setState(() {
      playerLeft -= 50;
      if (playerLeft < 0) {
        playerLeft = 0;
      }
    });
  }

  _moveRight(double maxWidth) {
    setState(() {
      playerLeft += 50;
      if (playerLeft > (maxWidth - 50)) {
        playerLeft = maxWidth - 50;
      }
    });
  }

  _fireMissile() {
    if (missileController.isDismissed) {
      missileController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final maxHeight = constraints.maxHeight;

      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.pink[100],
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 20,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '$score',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              key: ValueKey<int>(score),
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: ballAnimation,
                        builder: (context, child) {
                          ballBottom = 3 / 4 * maxHeight / 2;
                          ballLeft = ballAnimation.value * (maxWidth - 20);
                          return Positioned(
                            left: ballLeft,
                            bottom: ballBottom,
                            child: child!,
                          );
                        },
                        child: const Ball(),
                      ),
                      AnimatedBuilder(
                        animation: missileAnimation,
                        builder: (context, child) {
                          missileBottom =
                              (3 / 4 * maxHeight) * missileAnimation.value;
                          missileLeft = playerLeft + 50 / 2 - 5 / 2;
                          return Positioned(
                            left: missileLeft,
                            bottom: missileBottom,
                            child: child!,
                          );
                        },
                        child: Missile(),
                      ),
                      Positioned(
                        left: playerLeft,
                        bottom: 0,
                        child: Player(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                      _moveLeft();
                    }
                    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                      _moveRight(maxWidth);
                    }
                    if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                      _fireMissile();
                    }
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ControlButton(
                              iconData: Icons.arrow_back,
                              onPressed: _moveLeft,
                            ),
                            ControlButton(
                              iconData: Icons.arrow_upward,
                              onPressed: _fireMissile,
                            ),
                            ControlButton(
                              iconData: Icons.arrow_forward,
                              onPressed: () => _moveRight(maxWidth),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ControlButton(
                              iconData: Icons.play_arrow,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
