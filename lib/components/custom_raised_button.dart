import 'package:flutter/material.dart';

defaultOnPressed() => true;

class CustomRaisedButton extends StatefulWidget {

  final EdgeInsets padding;
  final Function onPressed;
  final Color backgroundColor;
  final Widget child;

  CustomRaisedButton(
    {
      this.onPressed = defaultOnPressed, 
      this.backgroundColor = const Color(0xffe3e3e3),
      this.child, this.padding
    }
  );

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState(this.onPressed, this.backgroundColor, this.child, this.padding);
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {

  Function onPressed;
  Color backgroundColor;
  Widget child;
  EdgeInsets padding;

  _CustomRaisedButtonState(
    [
      this.onPressed = defaultOnPressed, 
      this.backgroundColor = const Color(0xffe3e3e3),
      this.child,
      this.padding
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6.0),
      child: RaisedButton(
        color: this.backgroundColor,
        onPressed: this.onPressed,
        padding: this.padding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: this.child ?? Container(),
      ),
      decoration: BoxDecoration(
        color: this.backgroundColor.withAlpha(140),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}