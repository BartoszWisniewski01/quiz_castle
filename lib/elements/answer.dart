import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({
    Key? key,
    required this.optionColor,
    required this.optionValue,
    required this.backColor,
    required this.answerColor,
    required this.optionIcon,
  }) : super(key: key);
  final Color optionColor;
  final String optionValue;
  final Color backColor;
  final Color answerColor;
  final IconData optionIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 1000,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                optionValue,
                style: TextStyle(
                  color: optionColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                optionIcon,
                color: answerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
