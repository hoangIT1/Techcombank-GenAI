//import SwiftUI
//
//struct ContentView: View {
//    
//    @StateObject private var viewModel = ContentViewModel()
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack {
//                ScrollViewReader { proxy in
//                    ScrollView {
//                        LazyVStack(spacing: 16) {
//                            ForEach(viewModel.chatMessages) { message in
//                                messageView(message)
//                            }
//                            
//                            Color.clear
//                                .frame(height: 1)
//                                .id("bottom")
//                        }
//                    }
//                    .onReceive(viewModel.$chatMessages.throttle(for: 0.5, scheduler: RunLoop.main, latest: true)) { chatMessages in
//                        guard !chatMessages.isEmpty else { return }
//                        withAnimation {
//                            proxy.scrollTo("bottom")
//                        }
//                    }
//                }
//                .padding(.top, geometry.safeAreaInsets.top - 55)
//                
//                HStack {
//                    TextField("✨ Let SigMO help you ...✨", text: $viewModel.message, axis: .vertical)
//                        .textFieldStyle(.roundedBorder)
//                    if viewModel.isWaitingForResponse {
//                        ProgressView()
//                            .padding()
//                    } else {
//                        Button("Send") {
//                            sendMessage()
//                        }
//                        .buttonStyle(.borderedProminent)
//                    }
//                }
//                .padding()
//
//            }
//        }
//    }
//    
//    func messageView(_ message: ChatMessage) -> some View {
//        HStack {
//            if message.owner == .user {
//                Spacer(minLength: 60)
//            }
//            
//            if !message.text.isEmpty {
//                VStack {
//                    Text(message.text)
//                        .foregroundColor(message.owner == .user ? .white : .black)
//                        .padding(12)
//                        .background(message.owner == .user ? Color.blue : Color.gray.opacity(0.1))
//                        .cornerRadius(16)
//                        .overlay(alignment: message.owner == .user ? .topTrailing : .topLeading) {
//                            Text(message.owner == .user ? "User" : "SigMO")
//                                .foregroundColor(.gray)
//                                .font(.caption)
//                                .offset(y: -16)
//                        }
//                }
//            }
//            
//            if message.owner == .sigMO {
//                Spacer(minLength: 60)
//            }
//        }
//        .padding(.horizontal)
//    }
//    
//    func sendMessage() {
//        Task {
//            do {
//                try await viewModel.sendMessage()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI
import Lottie

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var showChatBot = false
    
    var body: some View {
        ZStack {
            
            Image("TechcombankBG.jpg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
           
            VStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        showChatBot.toggle()
                    }
                }) {
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
            
            if showChatBot {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                showChatBot = false
                            }
                        }
                    
                    VStack {
                        Spacer()
                        ChatBotView(viewModel: viewModel)
                            .frame(height: 650)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .transition(.move(edge: .bottom))
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }
}


struct ChatBotView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    ZStack(alignment: .bottomTrailing) {
                        Image("symbol.png")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .shadow(radius: 10)
                        
                        Circle()
                            .fill(Color.green)
                            .frame(width: 15, height: 15)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            
                    }
                    .padding(.leading, 8)
                    
                    Text("Hi there, I'm SigMO 👋")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                )
                
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.chatMessages) { message in
                                messageView(message)
                            }
                            
                            Color.clear
                                .frame(height: 1)
                                .id("bottom")
                        }
                    }
                    .onReceive(viewModel.$chatMessages.throttle(for: 0.5, scheduler: RunLoop.main, latest: true)) { chatMessages in
                        guard !chatMessages.isEmpty else { return }
                        withAnimation {
                            proxy.scrollTo("bottom")
                        }
                    }
                }
                .padding(.top, geometry.safeAreaInsets.top)
                
                if viewModel.isWaitingForResponse {
                    LottieViewHelper(filename: "loading.json", loopMode: .loop, animationSpeed: 0.5)
                        .frame(width: 200, height: 200)
                }
                
                HStack {
                    TextField("✨ Let SigMO help you ...✨", text: $viewModel.message)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 4)
                .background(Color.white)
                .overlay(
                    VStack {
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .frame(height: 1)
                            .padding(.bottom, 8)
                        Spacer()
                    }, alignment: .top
                )
                .padding(.horizontal)
                
                // Just for author
                HStack {
                    Text("Published by")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Link("Hoàng Dương", destination: URL(string: "https://www.facebook.com/profile.php?id=100007716785225")!)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 5)
                .offset(y: -6)
            }
        }
    }
    
    func messageView(_ message: ChatMessage) -> some View {
        HStack {
            if message.owner == .user {
                Spacer(minLength: 60)
            }
            
        
            if message.owner == .sigMO {
                Image("icon.png")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 8)
            }
            
            if !message.text.isEmpty {
                VStack {
                    Text(message.text)
                        .foregroundColor(message.owner == .user ? .white : .black)
                        .padding(12)
                        .background(message.owner == .user ? Color.blue : Color.gray.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(alignment: message.owner == .user ? .topTrailing : .topLeading) {
                            Text(message.owner == .user ? "User" : "SigMO")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .offset(x: 6, y: -20)
                        }
                }
            }
            
            if message.owner == .sigMO {
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal)
    }
    
    func sendMessage() {
        Task {
            do {
                try await viewModel.sendMessage()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
