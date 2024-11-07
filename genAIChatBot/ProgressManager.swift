import SwiftUI
import Combine

class ProgressManager: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isBoxVisible: Bool = false

    func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.progress < 1.0 {
                self.progress += 0.02 // Tăng tiến trình
            } else {
                timer.invalidate()
                self.isBoxVisible = false // Tắt box khi đạt 100%
            }
        }
    }
}
