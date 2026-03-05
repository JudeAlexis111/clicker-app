import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            MainClickView()
                .tabItem {
                    Label("Click", systemImage: "hand.tap")
                }

            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.xaxis")
                }
        }
    }
}

#Preview {
    RootView()
}
