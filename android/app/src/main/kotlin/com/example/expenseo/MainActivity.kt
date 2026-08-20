package com.example.expenseo

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.example.expenseo/widget"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Production Grade Security: Prevent screenshots and hide app content in Task Switcher
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }

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
