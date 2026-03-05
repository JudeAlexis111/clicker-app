import Foundation
import SwiftData

@Model
final class ClickEvent {
    var timestamp: Date

    init(timestamp: Date = .now) {
        self.timestamp = timestamp
    }
}
