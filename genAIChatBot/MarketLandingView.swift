import SwiftUI

struct MarketLandingView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Nút Back
//            HStack {
//                Spacer()
//                
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss() // Quay về màn hình trước đó
//                }) {
//                    Text("Back")
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                }
//                
//                Spacer()
//            }
//            .padding(.top, 40) // Đẩy nút xuống dưới
//            .padding(.horizontal)
//            
//            Spacer().frame(height: 10) // Tạo thêm khoảng cách dưới nút Back
            
            // Tiêu đề và chú thích
            VStack(alignment: .center, spacing: 3) {
                Text("AI-Powered Market Intelligence")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color("9747FF"))
                    
                Text("Get deep market insights in minutes, not days")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.top, 110)
            
            // Ảnh PNG
            Image("MarketLandingPage.png")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.top, 20)
            
            // TextFields
            ZStack {
                Image("MarketBG.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 350)
                        .opacity(0.1)
                
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Industry")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        ZStack {
                            // Background của TextField với padding cho nội dung
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color.white)
                                .frame(height: 60)

                            // TextField được đặt trong ZStack để áp dụng padding
                            TextField("", text: .constant(""))
                                .padding(.horizontal, 16) // Padding bên trong TextField
                                .frame(height: 60) // Đảm bảo chiều cao của TextField
                        }
                        
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Country")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        ZStack {
                            // Background của TextField với padding cho nội dung
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color.white)
                                .frame(height: 60)

                            // TextField được đặt trong ZStack để áp dụng padding
                            TextField("", text: .constant(""))
                                .padding(.horizontal, 16) // Padding bên trong TextField
                                .frame(height: 60) // Đảm bảo chiều cao của TextField
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Purpose")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        ZStack {
                            // Background của TextField với padding cho nội dung
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color.white)
                                .frame(height: 60)

                            // TextField được đặt trong ZStack để áp dụng padding
                            TextField("", text: .constant(""))
                                .padding(.horizontal, 16) // Padding bên trong TextField
                                .frame(height: 60) // Đảm bảo chiều cao của TextField
                        }
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
            
            
            // Nút Setting và Complete
            HStack {
                Button(action: {
                    // Thực hiện thao tác cài đặt
                }) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 25)) // Kích thước biểu tượng
                        .foregroundColor(.black) // Màu biểu tượng
                        .padding(10) // Khoảng cách giữa biểu tượng và nền
                        .background(Circle().fill(Color.white)) // Vòng tròn nền trắng
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 1) // Đường viền mỏng xung quanh
                        )
                }
                
                Spacer()
                
                Button(action: {
                    // Thực hiện thao tác hoàn thành
                }) {
                    Text("Research")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(24)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("D7D7FA"), Color("D7D7FA").opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
        .edgesIgnoringSafeArea(.all)
//        .navigationBarHidden(true)
    }
}

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
