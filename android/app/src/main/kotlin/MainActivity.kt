package com.experiments

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.experiments/BatteryPlugin"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Set up method channel for battery level communication
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method == "getBatteryLevel") {
                        val batteryLevel = getBatteryLevel()

                        if (batteryLevel != -1) {

                            result.success(batteryLevel)
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null)
                        }
                    } else {
                        result.notImplemented()
                    }
                }
    }

    // Function to get battery level
    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            -1
        }
    }
}
