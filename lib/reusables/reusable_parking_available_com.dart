import 'package:flutter/material.dart';
import 'package:mygarage/reusables/reusable_button.dart';

class ReusableParkingAvailableComp extends StatelessWidget {
  ReusableParkingAvailableComp(
      {this.buttonColor, this.text, this.onTap, this.textColor});
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          'images/car.png',
          width: 250,
          height: 250,
        ),
        ReusableButton(
          title: text,
          colour: buttonColor,
          onPressed: onTap,
        ),
      ],
    );
  }
}
