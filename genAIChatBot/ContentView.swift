import SwiftUI
import Lottie
import UserNotifications

struct ContentView: View {
    
    @State private var showCustomScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("TechcombankBG.jpg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Button để mở màn hình CustomScreenView
                    NavigationLink(destination: MarketLandingView()) {
                        Image("symbol.png")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                    }
                    
                    Spacer().frame(height: 30)
                }
            }
            .onAppear(perform: requestNotificationPermission)
            .navigationBarHidden(true) // Ẩn navigation bar mặc định
        }
    }

    private func requestNotificationPermission() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if !launchedBefore {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    print("Notification permission error: \(error)")
                } else {
                    print("Notification permission granted: \(granted)")
                }
            }
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
}
