import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantui/constants.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double topPadding;

  const CustomButton({Key key, this.label, this.onPressed, this.topPadding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: double.infinity,
          height: size.height * 0.049,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width < 411
                    ? 14.0
                    : size.width > 500
                        ? 21.0
                        : 16.0,
                fontFamily: ''),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
