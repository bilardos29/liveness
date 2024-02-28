import 'package:flutter/material.dart';
import 'package:liveness/feature/kakzaki_screen.dart';
import 'package:liveness/feature/m7_screen.dart';
import 'package:m7_livelyness_detection/index.dart';
import 'package:mnc_identifier_face/mnc_identifier_face.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result_model.dart';


class Liveness extends StatefulWidget {
  const Liveness({super.key});

  @override
  State<Liveness> createState() => _LivenessState();
}

class _LivenessState extends State<Liveness> {

  Future<void> startDetectionMNC() async {
    try {
      LivenessDetectionResult livenessResult =
      await MncIdentifierFace().startLivenessDetection();
      debugPrint("result is $livenessResult");
    } catch (e) {
      debugPrint('Something goes unexpected with error is $e');
    }
  }

  Future<void> startDetectionM7() async {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => const M7Screen()));
  }

  Future<void> startDetectionKakzaki() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const KakzakiScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () {
              startDetectionMNC();
            },
            child: const Text("Liveness using MNC"),),

            ElevatedButton(onPressed: () {
              startDetectionM7();
            },
            child: const Text("Liveness using M7"),),

            ElevatedButton(onPressed: () {
              startDetectionKakzaki();
            },
            child: const Text("Liveness using kakzaki"),),
          ],
        ),
      ),
    );
  }
}
