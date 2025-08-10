import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ModelPreparing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.grey.shade900,
        ),
        height: 300,
        width: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Text(
                "You First Time Right? :)",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Expanded(
              flex: 6,
              child: Lottie.asset("assets/animations/prepare_ai.json"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  "Your Private Ai Model Is Starting to Prepare Please Wait",
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                "It's Take About 1 Minute :)",
                maxLines: 2,
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
