import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  
  Offset horizontalSwipeStartPosition;
  Offset horizontalSwipeCurrentPosition;
  Offset verticalSwipeStartPosition;
  Offset verticalSwipeCurrentPosition;

  final Function onSwipeLeft;
  final Function onSwipeRight;
  final Function onSwipeDown;
  final Function onTap;
  final Function onDoubleTap;
  final Function onLongPress;
  final Widget child;

  CustomGestureDetector({this.onSwipeLeft, this.onSwipeRight, this.onSwipeDown, this.child, this.onTap, this.onDoubleTap, this.onLongPress});

  void startHorizontalSwipe(DragStartDetails details) {
    this.horizontalSwipeStartPosition = details.globalPosition;
  }

  void updateHorizontalSwipe(DragUpdateDetails details) {
    this.horizontalSwipeCurrentPosition = details.globalPosition;
  }

  void endHorizontalSwipe(DragEndDetails _) {
    if (this.horizontalSwipeCurrentPosition != null && this.horizontalSwipeStartPosition != null) {
      if (this.horizontalSwipeCurrentPosition.dx > this.horizontalSwipeStartPosition.dx) {
        this.onSwipeRight.call();
      } else {
        this.onSwipeLeft.call();
      }
    }
  }

  void startVerticalSwipe(DragStartDetails details) {
    this.verticalSwipeStartPosition = details.globalPosition;
  }

  void updateVerticalSwipe(DragUpdateDetails details) {
    this.verticalSwipeCurrentPosition = details.globalPosition;
  }

  void endVerticalSwipe(DragEndDetails _) {
    if (this.verticalSwipeCurrentPosition != null && this.verticalSwipeStartPosition != null) {
      if (this.verticalSwipeCurrentPosition.dy > this.verticalSwipeStartPosition.dy) {
        if (this.onSwipeDown != null) {
          this.onSwipeDown.call();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onHorizontalDragEnd: this.endHorizontalSwipe,
      onHorizontalDragStart: this.startHorizontalSwipe,
      onHorizontalDragUpdate: this.updateHorizontalSwipe,
      onVerticalDragEnd: this.endVerticalSwipe,
      onVerticalDragStart: this.startVerticalSwipe,
      onVerticalDragUpdate: this.updateVerticalSwipe,
      onTap: this.onTap,
      onDoubleTap: this.onDoubleTap,
      onLongPress: this.onLongPress,
    );
  }
}