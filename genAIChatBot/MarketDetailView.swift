import SwiftUI

struct MarketDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var industry: String
    var country: String
    var purpose: String
    @State private var completionRate = 0.0 // Tạm thời đặt completion rate là 75%
    @State private var numberArticles = 20 // Tạm thời giả lập 20 bài báo tìm thấy
    @State private var timer: Timer?
    let totalTime: Double = 300
    
    var body: some View {
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
                
                //Hiển thị phần trăm hoàn thành
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
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.leading)
            
            // Accordion mockup
            VStack(spacing: 10) {
                ForEach(0..<8, id: \.self) { index in
                    DisclosureGroup("Accordion Item \(index + 1)") {
                        Text("Content for item \(index + 1)")
                            .padding()
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(radius: 1)
                    .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("D7D7FA"), Color("D7D7FA").opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
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
        // Gọi MarketDetailView với dữ liệu giả lập cho preview
        MarketDetailView(industry: "Football", country: "Hoàng", purpose: "Dit me cuoc doi")
    }
}
