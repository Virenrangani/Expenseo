package com.example.expenseo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class ExpenseWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.expense_widget).apply {
                // Get data saved from Flutter via HomeWidget.saveWidgetData
                val balance = widgetData.getString("balance", "$0.00")
                val income = widgetData.getString("income", "$0.00")
                val expense = widgetData.getString("expense", "$0.00")

                setTextViewText(R.id.widget_balance, balance)
                setTextViewText(R.id.widget_income, income)
                setTextViewText(R.id.widget_expense, expense)
            }
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
