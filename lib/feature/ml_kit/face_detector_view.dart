import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:liveness/feature/ml_kit/face_model.dart';

import 'detector_view.dart';
import 'painters/face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  FaceDetectorView({required this.listFace});

  List<FaceModel> listFace;

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.front;

  FaceModel? faceModel;
  int indexFace = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.listFace != null) {
      faceModel = widget.listFace[0];
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _customPaint,
      instructionText: faceModel!.faceAction,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  changeFace() {
    if (indexFace < widget.listFace.length - 1) {
      indexFace += 1;
      faceModel = widget.listFace[indexFace];
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final faces = await _faceDetector.processImage(inputImage);
    /*
    * Untuk mengambil image bisa ambil dari input image
    * inputImage.filePath
    * */
    print("image : ${inputImage.filePath}");

    // if (inputImage.metadata?.size != null &&
    //     inputImage.metadata?.rotation != null) {
    //   final painter = FaceDetectorPainter(
    //     faces,
    //     inputImage.metadata!.size,
    //     inputImage.metadata!.rotation,
    //     _cameraLensDirection,
    //   );
    //   _customPaint = CustomPaint(painter: painter);
    // } else {
      for (Face face in faces) {
        processLiveness(face);
      // }
      // _customPaint = null;
    }


    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  processLiveness(Face face) {

    final double? rotX = face.headEulerAngleX; // Head is tilted up and down rotX degrees
    final double? rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
    final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

    // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
    // eyes, cheeks, and nose available):
    final FaceLandmark? earL = face.landmarks[FaceLandmarkType.leftEar];
    final FaceLandmark? earR = face.landmarks[FaceLandmarkType.rightEar];
    final FaceLandmark? mouthL = face.landmarks[FaceLandmarkType.leftMouth];
    final FaceLandmark? mouthR = face.landmarks[FaceLandmarkType.rightMouth];
    final FaceLandmark? eyeL = face.landmarks[FaceLandmarkType.leftEye];
    final FaceLandmark? eyeR = face.landmarks[FaceLandmarkType.rightEye];

    if (earL != null && earR != null &&
        mouthL != null && mouthR != null &&
        eyeL != null && eyeR != null) {
      switch (faceModel!.faceEnum) {
        case FaceEnum.lookDown : {
            if (rotX! < -30) {
              print("melihat ke bawah $rotX");
              changeFace();
            }
            break;
          }
        case FaceEnum.lookUp : {
            if (rotX! > 30) {
              print("melihat ke atas $rotX");
              changeFace();
            }
            break;
          }
        case FaceEnum.turnLeft : {
            if (rotY! > 30) {
              print("melihat kiri $rotY");
              changeFace();
            }
            break;
          }
        case FaceEnum.turnRight : {
            if (rotY! < -30) {
              print("melihat kanan $rotY");
              changeFace();
            }
            break;
          }
        case FaceEnum.blink : {
            final double? leftEyeOpenProb = face.leftEyeOpenProbability;
            final double? rightEyeOpenProb = face.rightEyeOpenProbability;
            if (leftEyeOpenProb != null && rightEyeOpenProb != null) {
              //untuk kedip berapa hitungannya x dan y nya
              if(leftEyeOpenProb < 0.2 && rightEyeOpenProb < 0.2) {
                changeFace();
              }
              print("mata kedip $leftEyeOpenProb - $rightEyeOpenProb");
            }
            break;
          }
        case FaceEnum.smile : {
            final double? smileProb = face.smilingProbability;
            if (smileProb! >= 0.9) {
              print("senyum $smileProb");
              changeFace();
            }
            break;
          }
        default:
          break;
      }
    } else {
      print("tidak ditemukan human");
    }
  }
}
