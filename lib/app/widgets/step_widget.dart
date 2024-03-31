import 'package:flutter/material.dart';

class StepListTile extends StatelessWidget {
  final String primaryText;
  final String titleText;
  final String subtitleText;
  final String trailing;

  const StepListTile({
    super.key,
    required this.primaryText,
    required this.titleText,
    required this.subtitleText,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Text(
            primaryText,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
                color: Color(0xff007663),
                fontFamily: "Roboto"),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(
                  titleText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Color(0xff444343),
                      fontFamily: "Roboto"),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitleText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Color(0xff605F5F),
                      fontFamily: "Roboto"),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 55,
              child: Image.asset(
                trailing,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
