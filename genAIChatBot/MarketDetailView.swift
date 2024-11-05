import SwiftUI
import UserNotifications
import BackgroundTasks

struct MarketDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var industry: String
    var country: String
    var purpose: String
    
    @StateObject private var viewModel = MarketDetailViewModel()
    
    @State private var completionRate = 0.0 // Tạm thời đặt completion rate là 75%
    @State private var numberArticles = 20 // Tạm thời giả lập 20 bài báo tìm thấy
    @State private var timer: Timer?
    @State private var isNotiEnable = false
    
    let totalTime: Double = 15
    
    var body: some View {
        ScrollView {
            VStack {
                // Nút Back
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                Spacer().frame(height: 10)
                
                // Tiêu đề
                VStack(alignment: .leading, spacing: 3) {
                    Text("\(industry) in \(country)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color("9747FF"))
                    
                    Text("\(purpose)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 20)
                
                // Thanh Completion Rate và Toggle
               HStack {
                   Toggle("Notification", systemImage: isNotiEnable ? "bell.circle.fill" : "bell.slash.circle.fill", isOn: $isNotiEnable)
                       .font(.system(size: 22))
                       .foregroundColor(isNotiEnable ? .blue : .gray)
                       .toggleStyle(.button)
                       .contentTransition(.symbolEffect)
                       .onChange(of: isNotiEnable) { newValue in
                           print("isNotiEnable: \(newValue)")
                       }
                   
                   
                   Spacer()
                   
                   ProgressView(value: completionRate, total: totalTime)
                       .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                       .frame(width: 150, height: 30)
                       .scaleEffect(x: 1, y: 10, anchor: .center)
                       .clipShape(RoundedRectangle(cornerRadius: 32))
                       .padding(.horizontal)
               }
               .onAppear {
                   startTimer()
               }
               .padding(.horizontal)
               
               // Hiển thị phần trăm hoàn thành
               if completionRate.truncatingRemainder(dividingBy: 1) == 0 {
                   let percentage = Int((completionRate / totalTime) * 100)
                   Text("Complete \(percentage)%")
                       .font(.subheadline)
                       .foregroundColor(.black)
                       .padding(.trailing)
                       .frame(maxWidth: .infinity, alignment: .trailing)
                   }
                
                // Số bài báo tìm thấy
                Text("\(numberArticles) articles found")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                // Accordion mockup
                VStack(spacing: 10) {
                    DisclosureGroup {
                        Text("As an AI Analyst, I am imperfect. No matter what my Managing Director says, I do make mistakes. However, I am fast and cheap. I may miss some important Company names in certain markets, and occasionally I may misrepresent concepts. Generally everything you see below is taken from a report I see, but occasionally I make mistakes as I read 10,242,932 words a day. Forgive me! I am getting better every day.")
                            .font(.system(size: 15))
                            .italic()
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Disclaimer")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text("Oops, this feature is not avaible right now, Please waiting for update 😜")
                            .font(.system(size: 15))
                            .italic()
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Infographics")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text("Oops, this feature is not avaible right now, Please waiting for update 😜")
                            .font(.system(size: 15))
                            .italic()
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Analyst Performance")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text(viewModel.summaryContent)
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Summary")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text(viewModel.overviewContent)
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Overview")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text(viewModel.competitionContent)
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Competition")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text(viewModel.customersContent)
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Customers")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                    DisclosureGroup {
                        Text(viewModel.keyDataContent)
                            .font(.system(size: 15))
                            .padding()
                            .foregroundColor(.black)
                    } label: {
                        Text("Key Data")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 40)

                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("D7D7FA"), Color("D7D7FA").opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all) // Bỏ qua Safe Area
        }
        .edgesIgnoringSafeArea(.all) // Bỏ qua Safe Area cho ScrollView
    }
    
    func startTimer() {
        completionRate = 0
        timer?.invalidate()
        sendCompletionNotification()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if completionRate < totalTime {
                completionRate += 1
                print(completionRate)
                print(totalTime)
            } else {
                timer?.invalidate()
                if isNotiEnable {
                    sendCompletionNotification()
                }
            }
        }
    }
    
    
    
    func sendCompletionNotification() {
        print("Đang chạy ...")
        let content = UNMutableNotificationContent()
        content.title = "Hoàn thành Tiến trình"
        content.body = "Tiến trình đã đạt 100%."
        content.sound = .default

        // Sử dụng trigger thời gian để đảm bảo thông báo được hiển thị
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Lỗi thông báo: \(error)")
            } else {
                print("Thông báo đã được lên lịch thành công")
            }
        }
    }

}

struct MarketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarketDetailView(industry: "Football", country: "Hoàng", purpose: "Purpose Placeholder")
    }
}
