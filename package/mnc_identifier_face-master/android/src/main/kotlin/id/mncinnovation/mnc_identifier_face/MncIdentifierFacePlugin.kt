package id.mncinnovation.mnc_identifier_face

import android.app.Activity
import android.app.Activity.RESULT_OK
import androidx.annotation.NonNull
import android.content.Context
import android.content.Intent
import android.util.Log
import id.mncinnovation.face_detection.MNCIdentifier
import id.mncinnovation.face_detection.analyzer.DetectionMode
import com.google.gson.Gson

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MncIdentifierFacePlugin */
class MncIdentifierFacePlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var activity : Activity
  private lateinit var context : Context
  private lateinit var result : Result


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mnc_identifier_face")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  companion object {
    const val LIVENESS_DETECTION_REQUEST_CODE = 666
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    this.result = result
    if (call.method == "startLivenessDetection") {
      setDetectionModeSequenceFromParams(call);

      activity.startActivityForResult(MNCIdentifier.getLivenessIntent(context), LIVENESS_DETECTION_REQUEST_CODE)
    } else {
      result.notImplemented()
    }
  }
 fun setDetectionModeSequenceFromParams(@NonNull call: MethodCall){
    val arguments = call.argument<List<String>?>("detectionMode")
    val detectionModes = mutableListOf<DetectionMode>()
    if(!arguments.isNullOrEmpty()) {
      arguments?.forEach {
        when (it) {
          "HOLD_STILL" -> detectionModes.add(DetectionMode.HOLD_STILL)
          "BLINK" -> detectionModes.add(DetectionMode.BLINK)
          "OPEN_MOUTH" -> detectionModes.add(DetectionMode.OPEN_MOUTH)
          "SMILE" -> detectionModes.add(DetectionMode.SMILE)
          "SHAKE_HEAD" -> detectionModes.add(DetectionMode.SHAKE_HEAD)
          else -> {}
        }
      }

      MNCIdentifier.setDetectionModeSequence(false, detectionModes)
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (resultCode == RESULT_OK) {
      when (requestCode) {
        LIVENESS_DETECTION_REQUEST_CODE -> {
          //get liveness result
          val livenessResult = MNCIdentifier.getLivenessResult(data)
          livenessResult?.let { res ->
            if (res.isSuccess) {  // check if liveness detection success
              // get image result
              val bitmap = res.getBitmap(context, DetectionMode.SMILE)
              var gson = Gson()
              
              result.success(gson.toJson(res))
            } else {  //Liveness Detection Error
              result.error("Invalid request code", "Mnc-identifier-face: Received request code: $requestCode", "Expected request code: ${LIVENESS_DETECTION_REQUEST_CODE}_REQUEST_CODE")
            }
          }
        }

      }
      return true
    }
    return false
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.getActivity()
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
//    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
//    TODO("Not yet implemented")
  }
}
