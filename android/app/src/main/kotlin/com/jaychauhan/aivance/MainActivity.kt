package com.jaychauhan.aivance

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.StatFs
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.jaychauhan.aivance/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                try {
                    val info = HashMap<String, Any?>()

                    // Phone model
                    val manufacturer = Build.MANUFACTURER?.replaceFirstChar { it.uppercase() } ?: ""
                    val model = Build.MODEL ?: ""
                    info["phone"] = if (model.startsWith(manufacturer, ignoreCase = true)) model else "$manufacturer $model"

                    // CPU info
                    info["cpu"] = if (Build.SUPPORTED_ABIS.isNotEmpty()) Build.SUPPORTED_ABIS[0] else (Build.HARDWARE ?: "ARM")

                    // RAM info
                    val actManager = getSystemService(Context.ACTIVITY_SERVICE) as? ActivityManager
                    if (actManager != null) {
                        val memInfo = ActivityManager.MemoryInfo()
                        actManager.getMemoryInfo(memInfo)
                        info["totalRamMb"] = (memInfo.totalMem / (1024 * 1024)).toInt()
                        info["availRamMb"] = (memInfo.availMem / (1024 * 1024)).toInt()
                    }

                    // Storage info
                    try {
                        val stat = StatFs(Environment.getDataDirectory().path)
                        val totalBytes = stat.blockSizeLong * stat.blockCountLong
                        val availBytes = stat.blockSizeLong * stat.availableBlocksLong
                        info["totalStorageMb"] = (totalBytes / (1024 * 1024)).toInt()
                        info["availStorageMb"] = (availBytes / (1024 * 1024)).toInt()
                    } catch (_: Exception) {
                    }

                    result.success(info)
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
