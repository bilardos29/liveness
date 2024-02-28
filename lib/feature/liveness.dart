import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liveness/feature/m7_screen.dart';
import 'package:mnc_identifier_face/mnc_identifier_face.dart';


class Liveness extends StatefulWidget {
  const Liveness({super.key});

  @override
  State<Liveness> createState() => _LivenessState();
}

class _LivenessState extends State<Liveness> {

  final List<DetectionMode> detectionModes = [
    DetectionMode.HOLD_STILL,
    DetectionMode.SHAKE_HEAD,
    DetectionMode.BLINK,
    DetectionMode.OPEN_MOUTH,
    DetectionMode.SMILE,
  ];

  final MncIdentifierFace faceLivenessDetection = MncIdentifierFace();

  List<DetectionMode> get _getRandomDetectionModes {
    final random = Random();
    var index1 = 0;
    var index2 = random.nextInt(detectionModes.length);
    while (index2 == index1) {
      index2 = random.nextInt(detectionModes.length);
    }

    return [detectionModes[0], detectionModes[index2]];
  }

  Future<void> startDetectionMNC() async {
    try {
      final livenessDetectionResult =
      await MncIdentifierFace().startLivenessDetection(
        detectionModes: _getRandomDetectionModes,
      );
      debugPrint("result is ${livenessDetectionResult!.isSuccess}");
    } catch (e) {
      debugPrint('Something goes unexpected with error is $e');
    }
  }

  Future<void> startDetectionM7() async {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => const M7Screen()));
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
            //
            // ElevatedButton(onPressed: () {
            //   startDetectionKakzaki();
            // },
            // child: const Text("Liveness using kakzaki"),),
          ],
        ),
      ),
    );
  }
}
