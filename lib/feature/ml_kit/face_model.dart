
enum FaceEnum {
  lookDown, turnLeft, turnRight, lookUp, smile, blink
}

class FaceModel {
  final String faceAction;
  final FaceEnum faceEnum;
  FaceModel({required this.faceAction, required this.faceEnum});
}