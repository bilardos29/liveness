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
  final MncIdentifierFace faceLivenessDetection = MncIdentifierFace();

  Future<void> startDetectionMNC() async {
    try {
      final livenessDetectionResult =
      await MncIdentifierFace().startLivenessDetection(
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
