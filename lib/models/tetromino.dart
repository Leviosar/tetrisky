import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'vector2.dart';

enum Direction {
  left,
  right,
  up,
  down,
}

enum TetrominoType {
  t,
  i,
  o,
  j,
  l,
  s,
  z
}

class TetrominoColor {
  static Color get(TetrominoType type) {
    Map<TetrominoType, Color> colors = {
      TetrominoType.i : Color(0xff264653),
      TetrominoType.j : Color(0xff2a9d8f),
      TetrominoType.t : Color(0xffe9c46a),
      TetrominoType.l : Color(0xfff4a261),
      TetrominoType.s : Color(0xffe76f51),
      TetrominoType.z : Color(0xffFFADAD),
      TetrominoType.o : Color(0xffBDB2FF),
    };

    return colors[type];
  }
}

class TetrominoIconShape {
  static List<Vector2> get(TetrominoType type) {
    Map<TetrominoType, List<Vector2>> shapes = {
      TetrominoType.i: [
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(2, 1),
        Vector2(3, 1),
      ],
      TetrominoType.j: [
        Vector2(0, 0),
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(2, 1),
      ],
      TetrominoType.l: [
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(2, 1),
        Vector2(2, 0),
      ],
      TetrominoType.s: [
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(1, 0),
        Vector2(2, 0),
      ],
      TetrominoType.t: [
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(2, 1),
        Vector2(1, 0),
      ],
      TetrominoType.z: [
        Vector2(0, 0),
        Vector2(1, 0),
        Vector2(1, 1),
        Vector2(2, 1),
      ],
      TetrominoType.o: [
        Vector2(0, 0),
        Vector2(1, 1),
        Vector2(0, 1),
        Vector2(1, 0),
      ],
    };

    return shapes[type];
  }
}

class TetrominoShape {
  static List<Vector2> get(TetrominoType type, Vector2 screen) {
    Map<TetrominoType, List<Vector2>> shapes = {
      TetrominoType.i: [
        Vector2((screen.x / 2 - 2).floor(), -1),
        Vector2((screen.x / 2 - 1).floor(), -1),
        Vector2((screen.x / 2 - 0).floor(), -1),
        Vector2((screen.x / 2 + 1).floor(), -1),
      ],
      TetrominoType.j: [
        Vector2((screen.x / 2 - 1).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(),  0),
        Vector2((screen.x / 2 - 1).floor(), -1),
      ],
      TetrominoType.l: [
        Vector2((screen.x / 2 - 1).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(), -1),
      ],
      TetrominoType.s: [
        Vector2((screen.x / 2 - 1).floor(), -1),
        Vector2((screen.x / 2 + 0).floor(), -1),
        Vector2((screen.x / 2 + 0).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(),  0),
      ],
      TetrominoType.t: [
        Vector2((screen.x / 2 - 1).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(), -1),
      ],
      TetrominoType.z: [
        Vector2((screen.x / 2 - 1).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(),  0),
        Vector2((screen.x / 2 + 0).floor(), -1),
        Vector2((screen.x / 2 + 1).floor(), -1),
      ],
      TetrominoType.o: [
        Vector2((screen.x / 2 - 0).floor(), -1),
        Vector2((screen.x / 2 + 1).floor(), -1),
        Vector2((screen.x / 2 - 0).floor(),  0),
        Vector2((screen.x / 2 + 1).floor(),  0),
      ],
    };

    return shapes[type];
  }
}

class Tetromino {
  int px = 0;
  int py = 0;

  List<Vector2> points = List<Vector2>(4);
  List<Vector2> iconPoints = List<Vector2>(4);
  Vector2 rotationCenter;
  TetrominoType type;
  Color color;

  Tetromino(this.type, Vector2 screen) {
    this.points = TetrominoShape.get(type, screen);
    this.iconPoints = TetrominoIconShape.get(type);
    this.rotationCenter = this.points[1];
    this.color = TetrominoColor.get(type);
  }

  void rotate([Direction direction = Direction.left, Vector2 screen]) {
    if (direction == Direction.right) {
      this.points.forEach((point) {
        int x = point.x;
        point.x = rotationCenter.x - point.y + rotationCenter.y;
        point.y = rotationCenter.y + x - rotationCenter.x;
      });

      if (!this.allPointsInField(screen)) {
        this.rotate(Direction.left, screen);
      }
    } else {
      this.points.forEach((point) {
        int x = point.x;
        point.x = rotationCenter.x + point.y - rotationCenter.y;
        point.y = rotationCenter.y - x + rotationCenter.x;
      });

      if (!this.allPointsInField(screen)) {
        this.rotate(Direction.right, screen);
      }
    }
  }

  void move(Direction direction, Vector2 screen) {
    if (direction == Direction.left && this.canMoveHorizontally(-1, screen)) {
      this.points.forEach((point) => point.x -= 1 );
    }
    
    if (direction == Direction.right && this.canMoveHorizontally(1, screen)) {
      this.points.forEach((point) => point.x += 1 );
    }
    
    if (direction == Direction.up) {
      this.points.forEach((point) => point.y -= 1 );
    }

    if (direction == Direction.down) {
      this.points.forEach((point) => point.y += 1 );
    }
  }

  bool canMoveHorizontally(int amount, Vector2 screen) {
    for (var point in this.points) {
      if (point.x + amount < 0 || point.x + amount >= screen.x) {
        return false;
      } 
    }

    return true;
  }

  bool allPointsInField(Vector2 screen) {
    for (var point in this.points) {
      if (point.x < 0 || point.x >= screen.x) {
        return false;
      } 
    }

    return true;
  }

  List<Positioned> show(int pointSize) {
    List<Positioned> points = this.points.map((point) {
      return new Positioned(
        child: Container(
          width: pointSize.toDouble(),
          height: pointSize.toDouble(),
          decoration: BoxDecoration(
            color: this.color,
            border: Border.all(color: Colors.white)
          ),
        ),
        left: (point.x * pointSize).toDouble(),
        top: (point.y * pointSize).toDouble(),
      );
    }).toList();

    return points;
  }

  List<Positioned> icon(int pointSize) {
    List<Positioned> points = this.iconPoints.map((point) {
      return new Positioned(
        child: Container(
          width: pointSize.toDouble(),
          height: pointSize.toDouble(),
          decoration: BoxDecoration(
            color: this.color,
          ),
        ),
        left: (point.x * pointSize).toDouble(),
        top: (point.y * pointSize).toDouble(),
      );
    }).toList();

    return points;
  }

  bool bottom(int boardBottom) {
    for (var point in points) {
      if (point.y == boardBottom - 1) return true;
    }

    return false;
  }
}