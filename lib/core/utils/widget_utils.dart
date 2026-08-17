import 'package:home_widget/home_widget.dart';

class WidgetUtils {
  static Future<void> updateWidget({
    required String balance,
    required String income,
    required String expense,
  }) async {
    try {
      // Save data to HomeWidget storage
      await HomeWidget.saveWidgetData<String>('balance', balance);
      await HomeWidget.saveWidgetData<String>('income', income);
      await HomeWidget.saveWidgetData<String>('expense', expense);

      // Trigger the update for the Android widget
      await HomeWidget.updateWidget(
        name: 'ExpenseWidgetProvider',
        androidName: 'ExpenseWidgetProvider',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
