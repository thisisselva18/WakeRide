package com.example.bus_app

import android.media.RingtoneManager
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.media.Ringtone
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "flutter_channel"
    
    // Global variables to manage the currently playing ringtone and the stop timer
    private var currentRingtone: Ringtone? = null
    private val handler = Handler(Looper.getMainLooper())
    private var stopRunnable: Runnable? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getRingtones" -> {
                    val ringtones = getRingtones()
                    result.success(ringtones)
                }
                "playRingtone" -> {
                    val ringtoneData = call.argument<Map<String, Any>>("ringtone")
                    val durationSeconds = call.argument<Int>("durationSeconds") ?: 5
                    if (ringtoneData != null) {
                        playRingtone(ringtoneData, durationSeconds)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "Ringtone data is missing or null.", null)
                    }
                }
                "stopRingtone" -> {
                    stopRingtone()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getRingtones(): List<Map<String, Any>> {
        val ringtoneList = mutableListOf<Map<String, Any>>()
        
        // Use RingtoneManager to fetch all system audio types (Ringtone, Notification, Alarm)
        val manager = RingtoneManager(this)
        manager.setType(RingtoneManager.TYPE_ALL)

        val cursor = manager.cursor
        while (cursor.moveToNext()) {
            val title = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
            val position = cursor.position
            val uri = manager.getRingtoneUri(position).toString()

            // Pass both the display name and the URI back to Flutter
            ringtoneList.add(mapOf(
                "name" to title,
                "uriString" to uri
            ))
        }
        cursor.close()
        return ringtoneList
    }

    private fun playRingtone(ringtoneData: Map<String, Any>, durationSeconds: Int) {
        stopRingtone()

        val uriString = ringtoneData["uriString"] as? String ?: return

        try {
            val uri = Uri.parse(uriString)
            currentRingtone = RingtoneManager.getRingtone(this, uri)
            
            currentRingtone?.let { ringtone ->
                if (!ringtone.isPlaying) {
                    ringtone.play()
                }

                // **FIX:** Explicitly implement java.lang.Runnable using an anonymous object
                // to satisfy the Handler API and resolve the type mismatch error.
                stopRunnable = object : java.lang.Runnable {
                    override fun run() {
                        stopRingtone()
                    }
                }

                // We can use !! here since we just assigned a non-null value to stopRunnable
                handler.postDelayed(stopRunnable!!, durationSeconds * 1000L)
            }
        } catch (e: Exception) {
            println("Error playing ringtone: ${e.message}")
        }
    }

    private fun stopRingtone() {
        // Stop any currently playing ringtone
        currentRingtone?.stop()
        
        // Remove the pending stop runnable from the handler queue
        stopRunnable?.let { handler.removeCallbacks(it) }

        // Clean up state
        currentRingtone = null
        stopRunnable = null
    }

    override fun onDestroy() {
        stopRingtone()
        super.onDestroy()
    }
}
