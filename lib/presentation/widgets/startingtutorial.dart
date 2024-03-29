import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> targets = [];
late TutorialCoachMark tutorialCoachMark;

void showTutorial(BuildContext context) {
  final size = MediaQuery.of(context).size;
  targets.add(TargetFocus(
    identify: "Target 1",
    targetPosition: TargetPosition(
      const Size.fromRadius(22),
      Offset(size.width - 66, size.height - 66),
    ),
    contents: [
      TargetContent(
          align: ContentAlign.left,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Get Started",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Click on the button to add your first password.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    ],
  ));

  WidgetsBinding.instance.addPostFrameCallback((_) {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.deepOrange,
      opacityShadow: 0.7,
      hideSkip: true,
    )..show();
  });
}
