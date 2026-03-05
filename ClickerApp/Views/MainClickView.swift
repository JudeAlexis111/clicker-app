import SwiftUI
import SwiftData

struct MainClickView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ClickEvent.timestamp, order: .reverse) private var clickEvents: [ClickEvent]

    private var todaysClicks: [ClickEvent] {
        ClickAnalytics.todayClicks(from: clickEvents)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                Text("Today: \(todaysClicks.count) clicks")
                    .font(.title2)
                    .bold()

                Button(action: registerClick) {
                    Text("Click")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .shadow(radius: 8)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .navigationTitle("Click Counter")
        }
    }

    private func registerClick() {
        modelContext.insert(ClickEvent(timestamp: .now))
    }
}

#Preview {
    MainClickView()
}
