import 'package:flutter/material.dart';
import 'package:mnc_identifier_face/mnc_identifier_face.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result_model.dart';

class Liveness extends StatefulWidget {
  const Liveness({super.key});

  @override
  State<Liveness> createState() => _LivenessState();
}

class _LivenessState extends State<Liveness> {

  Future<void> startDetection() async {
    try {
      LivenessDetectionResult livenessResult =
      await MncIdentifierFace().startLivenessDetection();
      debugPrint("result is $livenessResult");
    } catch (e) {
      debugPrint('Something goes unexpected with error is $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          startDetection();
        },
        child: Text("Take camera"),),
      ),
    );
  }
}
