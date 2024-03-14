import 'package:flutter/material.dart';
import 'package:liveness/feature/ml_kit/face_model.dart';
import 'package:mnc_identifier_face/mnc_identifier_face.dart';

import 'face_api_screen.dart';
import 'ml_kit/face_detector_view.dart';

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
          await MncIdentifierFace().startLivenessDetection();
      debugPrint("result is ${livenessDetectionResult!.isSuccess}");
    } catch (e) {
      debugPrint('Something goes unexpected with error is $e');
    }
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
            ElevatedButton(
              onPressed: () {
                startDetectionMNC();
              },
              child: const Text("Liveness using MNC"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FaceApiScreen()));
              },
              child: const Text("Face API"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FaceDetectorView(listFace: [
                          // FaceModel(faceAction: "Blink", faceEnum: FaceEnum.blink),
                          FaceModel(faceAction: "Smile", faceEnum: FaceEnum.smile),
                          // FaceModel(faceAction: "Look Up", faceEnum: FaceEnum.lookUp),
                        ],)));
              },
              child: const Text("Face Google ML Kit"),
            ),
          ],
        ),
      ),
    );
  }
}
