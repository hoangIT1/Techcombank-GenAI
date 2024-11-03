import SwiftUI

struct MarketDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var industry: String
    var country: String
    var purpose: String
    
    @StateObject private var viewModel = MarketDetailViewModel()
    
    @State private var completionRate = 0.0 // Tạm thời đặt completion rate là 75%
    @State private var numberArticles = 20 // Tạm thời giả lập 20 bài báo tìm thấy
    @State private var timer: Timer?
    let totalTime: Double = 300
    
    //mockup data from API
    @State private var summaryContent = "Nội dung summary"
    @State private var overviewContent = "Nội dung overview"
    @State private var competitionContent = "Nội dung competition"
    @State private var customersContent = "Nội dung customers"
    @State private var keyDataContent = "Nội dung keyData"
    
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
                
                // Thanh Completion Rate
                VStack {
                    ProgressView(value: completionRate, total: totalTime)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(width: 150, height: 30)
                        .scaleEffect(x: 1, y: 10, anchor: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .padding(.horizontal)
                    
                    // Hiển thị phần trăm hoàn thành
                    if completionRate.truncatingRemainder(dividingBy: 1) == 0 {
                        let percentage = Int((completionRate / totalTime) * 100)
                        Text("Complete \(percentage)%")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                }
                .onAppear {
                    startTimer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                
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
        timer?.invalidate() // Ngừng timer cũ nếu có
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if completionRate < totalTime {
                completionRate += 1
            } else {
                timer?.invalidate() // Ngừng timer khi đạt 5 phút
            }
        }
    }
}

struct MarketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarketDetailView(industry: "Football", country: "Hoàng", purpose: "Purpose Placeholder")
    }
}
