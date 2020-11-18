import 'dart:async';
import 'dart:collection';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../components/custom_gesture_detector.dart';
import '../../components/tetromino_hold_display.dart';
import '../../components/tetromino_queue_display.dart';
import '../../global/app_theme.dart';
import '../../helpers/tetromino_picker.dart';
import '../../models/tetromino.dart';
import '../../models/vector2.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  
  int pointSize = 20;
  int score = 0;
  
  AppTheme theme = BlocProvider.getDependency<AppTheme>();
  Duration updateRate = Duration(milliseconds: 400);
  Tetromino currentTetromino;
  Timer timer;
  Vector2 screen = Vector2(10, 20);

  List<Tetromino> tetrominos = [];
  Queue<Tetromino> next = Queue();
  Tetromino hold;
  bool holdLock = false;

  @override
  void initState() {
    this.startGame();
    super.initState();
  }

  void startGame() {
    setState(() {
      this.currentTetromino = TetrominoPicker.pick(this.screen);
    });

    this.next.add(TetrominoPicker.pick(screen));
    this.next.add(TetrominoPicker.pick(screen));
    this.next.add(TetrominoPicker.pick(screen));

    this.timer = new Timer.periodic(this.updateRate, this.update);
  }

  bool gameOver() {
    for (var tetromino in this.tetrominos) {
      for (var point in tetromino.points) {
        if (point.y <= 0) {
          return true;
        }
      } 
    }

    return false;
  }

  void update(Timer time) {
    if (this.currentTetromino == null || this.gameOver()) return;

    if (this.currentTetromino.bottom(this.screen.y) || this.checkColision()) {
      this.tetrominos.add(this.currentTetromino);
      
      this.checkFullRows();
      this.holdLock = false;

      setState(() {
        this.currentTetromino = this.next.removeFirst();
        this.next.add(TetrominoPicker.pick(this.screen));
      });
    }

    setState(() {
      this.currentTetromino.move(Direction.down, this.screen);
    });
  }

  Widget drawTetrominos() {
    if (this.currentTetromino == null) return null;
    
    List<Positioned> children = [
      ... this.currentTetromino.show(this.pointSize),
    ];

    for (var tetromino in this.tetrominos) {
      children.addAll(tetromino.show(this.pointSize));
    }

    return Stack(children: children);
  }

  bool checkColision() {
    for (var alivePoint in this.currentTetromino.points) {
      for (var tetromino in this.tetrominos) {
        for (var point in tetromino.points) {
          if (alivePoint.x == point.x && alivePoint.y == point.y - 1) {
            return true;
          }
        }
      }
    }

    return false;
  }

  void checkFullRows() {
    for (var row = 0; row < this.screen.y; row++) {
      int counter = 0;
      int removedRows = 0;

      for (var tetromino in this.tetrominos) {
        for (var point in tetromino.points) {
          if (point.y == row) counter++;
        }
      }

      if (counter >= this.screen.x) {
        removedRows += 1;
        removeRow(row);
      }

      this.increaseScore(removedRows);
    }
  }

  void holdPiece() {
    if (!this.holdLock) {
      this.holdLock = true;

      if (this.hold == null) {
        this.hold = this.currentTetromino;
        this.currentTetromino = this.next.removeFirst();
        this.next.add(TetrominoPicker.pick(screen));
      } else {
        this.currentTetromino = this.hold;
        this.hold = null;
      }
    }
  }

  void dropPiece() {
    while (!(this.currentTetromino.bottom(this.screen.y) || this.checkColision())) {
      print("descendo +1");
      setState(() {
        this.currentTetromino.move(Direction.down, this.screen);
      });
    }
  }

  void increaseScore(int rows) {
    switch (rows) {
      case 0:
        break;
      case 1:
        this.score += 100;
        break;
      case 2:
        this.score += 300;
        break;
      case 3:
        this.score += 500;
        break;
      case 4:
        this.score += 800;
        break;
      default:
        break;
    }
  }

  void removeRow(int index) {
    setState(() {
      for (var tetromino in this.tetrominos) {
        tetromino.points.removeWhere((Vector2 point) => point.y == index);

        tetromino.points.forEach((point) {
          if (point.y < index) {
            point.y += 1;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.buildBody(context),
      backgroundColor: this.theme.colors.green,
    );
  }

  Widget buildBody(BuildContext context) {
    return CustomGestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.buildPlayField(context)
          ],
        ),
      ),
      onDoubleTap: () => setState(() => this.holdPiece()),
      onLongPress: () => setState(() => this.dropPiece()),
      onSwipeDown: () => setState(() => this.dropPiece()),
      onTap: () => setState(() => this.currentTetromino.rotate(Direction.left, this.screen)),
      onSwipeLeft: () => setState(() => this.currentTetromino.move(Direction.left, this.screen)),
      onSwipeRight: () => setState(() => this.currentTetromino.move(Direction.right, this.screen)),
    );
  }

  Widget buildPlayField(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            )
          ),
          child: Text(this.score.toString().padLeft(3, '0'), style: TextStyle(fontSize: 30.0)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TetrominoHoldDisplay(this.hold),
            Container(
              padding: EdgeInsets.only(bottom: 6.0),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(140),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 8.0),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                child: Container(
                  width: (this.pointSize * 10).toDouble(),
                  height: (this.pointSize * 20).toDouble(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffffffff)),
                  ),
                  child: this.drawTetrominos(),
                ),
              ),
            ),
            TetrominoQueueDisplay(queue: this.next)
          ],
        )
      ],
    );
  }
}