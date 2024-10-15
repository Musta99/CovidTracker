import 'package:covid19_report/view/covid_virus_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(duration: Duration(seconds: 5), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryanimation) {
            return CovidVirusDataScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: controller.value * 2 * math.pi,
                  child: Image.asset(
                    "assets/images/virus.png",
                    height: Get.height * 0.4,
                    width: Get.width * 0.6,
                  ),
                );
              },
            ),
            Text(
              "Covid-19 Case Tracker",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Get.height * 0.035,
                color: Color(0xff0ca8c7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
