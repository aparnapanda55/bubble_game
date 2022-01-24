import 'package:bubble_trouble/ball.dart';
import 'package:bubble_trouble/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player.dart';
import 'misile.dart';

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
                        child: const Missile(),
                      ),
                      Positioned(
                        left: playerLeft,
                        bottom: 0,
                        child: const Player(),
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
