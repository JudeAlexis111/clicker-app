import Foundation

struct ClickDaySummary: Identifiable {
    let date: Date
    let count: Int

    var id: Date { date }
}

enum ClickAnalytics {
    static func startOfDay(for date: Date, calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: date)
    }

    static func todayClicks(from events: [ClickEvent], calendar: Calendar = .current) -> [ClickEvent] {
        let start = startOfDay(for: .now, calendar: calendar)
        guard let end = calendar.date(byAdding: .day, value: 1, to: start) else { return [] }

        return events.filter { event in
            (start..<end).contains(event.timestamp)
        }
    }

    static func clicksPerDay(from events: [ClickEvent], calendar: Calendar = .current) -> [ClickDaySummary] {
        var grouped: [Date: Int] = [:]

        for event in events {
            let day = startOfDay(for: event.timestamp, calendar: calendar)
            grouped[day, default: 0] += 1
        }

        return grouped
            .map { ClickDaySummary(date: $0.key, count: $0.value) }
            .sorted { $0.date < $1.date }
    }

    static func clicksByHourForToday(from events: [ClickEvent], calendar: Calendar = .current) -> [HourPoint] {
        let today = todayClicks(from: events, calendar: calendar)
        var grouped: [Int: Int] = [:]

        for event in today {
            let hour = calendar.component(.hour, from: event.timestamp)
            grouped[hour, default: 0] += 1
        }

        return (0...23)
            .map { HourPoint(hour: $0, count: grouped[$0, default: 0]) }
    }
}

struct HourPoint: Identifiable {
    let hour: Int
    let count: Int

    var id: Int { hour }
}
