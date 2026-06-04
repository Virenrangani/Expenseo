import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), expense: "₹0")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (SimpleEntry) -> ()
    ) {
        let entry = SimpleEntry(date: Date(), expense: readExpense())
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let entry = SimpleEntry(date: Date(), expense: readExpense())
        let timeline = Timeline(
            entries: [entry],
            policy: .after(Date().addingTimeInterval(15 * 60))
        )
        completion(timeline)
    }

    // ✅ FIXED: App Group ID now matches Flutter side exactly
    func readExpense() -> String {
        let defaults = UserDefaults(suiteName: "group.com.example.expenseo")
        return defaults?.string(forKey: "totalExpense") ?? "₹0"
    }
}

// MARK: - Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let expense: String
}

// MARK: - Widget View
struct ExpenseWidgetEntryView: View {

    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            Text("Today's Expense")
                .font(.caption)
                .foregroundColor(.secondary)

            Text(entry.expense)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding()
        // ✅ FIXED: Required for iOS 17+ widgets, safe fallback for older iOS
        .if_available_containerBackground()
    }
}

// ✅ FIXED: iOS 17 containerBackground compatibility extension
extension View {
    func if_available_containerBackground() -> some View {
        if #available(iOS 17.0, *) {
            return AnyView(
                self.containerBackground(.background, for: .widget)
            )
        } else {
            return AnyView(self)
        }
    }
}

// MARK: - Widget Configuration
struct ExpenseWidget: Widget {

    let kind = "ExpenseWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExpenseWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Expense Tracker")
        .description("Shows today's expenses")
        .supportedFamilies([.systemSmall, .systemMedium]) // ✅ explicitly declare sizes
    }
}
