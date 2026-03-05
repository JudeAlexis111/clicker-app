import SwiftUI
import SwiftData
import Charts

struct DashboardView: View {
    @Query(sort: \ClickEvent.timestamp, order: .forward) private var clickEvents: [ClickEvent]

    private var daySummary: [ClickDaySummary] {
        ClickAnalytics.clicksPerDay(from: clickEvents)
    }

    private var todayTimestamps: [ClickEvent] {
        ClickAnalytics.todayClicks(from: clickEvents)
    }

    private var hourlyToday: [HourPoint] {
        ClickAnalytics.clicksByHourForToday(from: clickEvents)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Clicks per day")
                        .font(.headline)

                    Chart(daySummary) { item in
                        BarMark(
                            x: .value("Day", item.date, unit: .day),
                            y: .value("Clicks", item.count)
                        )
                    }
                    .frame(height: 220)

                    Text("Today by hour")
                        .font(.headline)

                    Chart(hourlyToday) { point in
                        LineMark(
                            x: .value("Hour", point.hour),
                            y: .value("Clicks", point.count)
                        )
                        PointMark(
                            x: .value("Hour", point.hour),
                            y: .value("Clicks", point.count)
                        )
                    }
                    .frame(height: 220)

                    Text("Today's click timestamps")
                        .font(.headline)

                    if todayTimestamps.isEmpty {
                        Text("No clicks recorded today.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(todayTimestamps, id: \.persistentModelID) { event in
                            Text(event.timestamp.formatted(date: .omitted, time: .standard))
                                .font(.body.monospacedDigit())
                                .padding(.vertical, 2)
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
