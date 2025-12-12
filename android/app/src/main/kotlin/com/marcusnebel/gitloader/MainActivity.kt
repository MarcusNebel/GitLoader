package com.marcusnebel.gitloader

import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.ApplicationInfo

class MainActivity : FlutterActivity() {

    private val CHANNEL = "app.installer/check"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            val pm = applicationContext.packageManager

            when (call.method) {
                "isAppInstalledByLabel" -> {
                    val label = call.argument<String>("label") ?: ""
                    val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)
                    val found = apps.any {
                        pm.getApplicationLabel(it).toString().equals(label, ignoreCase = true)
                    }
                    result.success(found)
                }

                "getInstalledPackages" -> {
                    val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)

                    val filtered = apps.filter { appInfo ->
                        val system = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
                        val updatedSystem = (appInfo.flags and ApplicationInfo.FLAG_UPDATED_SYSTEM_APP) != 0

                        !(system && !updatedSystem)
                    }.map { it.packageName }

                    result.success(filtered)
                }

                "getPackageVersion" -> {
                    val packageName = call.argument<String>("package") ?: ""
                    try {
                        val info = pm.getPackageInfo(packageName, 0)
                        result.success(info.versionName)
                    } catch (e: PackageManager.NameNotFoundException) {
                        result.success(null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}
