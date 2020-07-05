package com.example.flutternativetut;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;


import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.test/test";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, Result result) {
          if (methodCall.method.equals("changeLife")){
            String message ="Life Changed";
            result.success(message);
          }
          if (methodCall.method.equals("vibrateDevice")) {
            result.success(vibratePhone());
          }
        }
      }
    );
  }

  private String vibratePhone(){
    long vibrateTime = 1500L;
    Vibrator v = (Vibrator) getSystemService(Context. VIBRATOR_SERVICE ) ;
    // Vibrate for 500 milliseconds
    if (Build.VERSION. SDK_INT >= Build.VERSION_CODES. O ) {
      v.vibrate(VibrationEffect. createOneShot ( vibrateTime ,
              VibrationEffect. DEFAULT_AMPLITUDE )) ;
    } else {
      //deprecated in API 26
      v.vibrate( vibrateTime ) ;
    }

    return "Device vibrated for " + vibrateTime + " milliseconds";
  }

}



              