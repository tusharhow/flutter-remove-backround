import 'package:flutter/material.dart';

class ReusablePrimaryButton extends StatelessWidget {
  const ReusablePrimaryButton({
    Key? key,
    required this.childText,
    required this.textColor,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  final String childText;
  final Function onPressed;
  final Color textColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as VoidCallback,
      child: Container(
        height: 53,
        width: MediaQuery.of(context).size.width / 1.10,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
            child: Text(
          childText,
          style: TextStyle(
            fontSize: 15,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        )),
      ),
    );
  }
}
