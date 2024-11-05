import SwiftUI
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Đăng ký Background Task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.app.refresh", using: nil) { task in
            self.handleBackgroundTask(task: task as! BGProcessingTask)
        }
        return true
    }

    func handleBackgroundTask(task: BGProcessingTask) {
        scheduleBackgroundTask() // Tạo lại task sau khi hoàn thành
        task.expirationHandler = {
            task.setTaskCompleted(success: false) // Nếu hết thời gian trước khi hoàn thành
        }
        
        // Thực hiện task của bạn tại đây
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            task.setTaskCompleted(success: true)
        }
    }
    
    func scheduleBackgroundTask() {
        let request = BGProcessingTaskRequest(identifier: "com.example.app.refresh")
        request.requiresNetworkConnectivity = true
        request.requiresExternalPower = false
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Không thể lên lịch background task: \(error)")
        }
    }
}
