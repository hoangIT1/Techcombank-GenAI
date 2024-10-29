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
            Text("Tiêu đề")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Chú thích cho tiêu đề")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Ảnh PNG
            Image("example_image")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 20)
            
            // TextFields
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Label 1")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Input 1", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Label 2")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Input 2", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Label 3")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Input 3", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()
            
            // Nút Setting và Complete
            HStack {
                Button(action: {
                    // Thực hiện thao tác cài đặt
                }) {
                    Text("Setting")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: {
                    // Thực hiện thao tác hoàn thành
                }) {
                    Text("Complete")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
//        .navigationBarHidden(true)
    }
}
