package com.example.expenseo

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.expenseo/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                val balance = call.argument<String>("balance")
                val income = call.argument<String>("income")
                val expense = call.argument<String>("expense")

                updateWidgetData(balance, income, expense)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updateWidgetData(balance: String?, income: String?, expense: String?) {
        val prefs = getSharedPreferences("DATA", Context.MODE_PRIVATE)
        val editor = prefs.edit()
        editor.putString("balance", balance)
        editor.putString("income", income)
        editor.putString("expense", expense)
        editor.apply()

        val intent = Intent(this, ExpenseWidgetProvider::class.java)
        intent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        val ids = AppWidgetManager.getInstance(application).getAppWidgetIds(ComponentName(application, ExpenseWidgetProvider::class.java))
        intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
        sendBroadcast(intent)
    }
}
