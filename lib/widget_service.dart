import 'package:home_widget/home_widget.dart';

class WidgetService {
  // ✅ Make sure this EXACTLY matches your iOS App Group
  static const appGroupId = 'group.com.example.expenseo';

  static Future<void> init() async {
    await HomeWidget.setAppGroupId(appGroupId);
  }

  static Future<void> updateExpenseWidget(String amount) async {
    await HomeWidget.saveWidgetData<String>('totalExpense', amount);
    await HomeWidget.updateWidget(iOSName: 'ExpenseWidget');
  }
}
