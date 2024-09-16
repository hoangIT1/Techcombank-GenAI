////
////  LottieView.swift
////  genAIChatBot
////
////  Created by Mac on 13/09/2024.
////
//
//import SwiftUI
//import Lottie
//
//struct LottieViewHelper: View {
//    var filename: String = "loading.json"
//    var contentMode: UIView.ContentMode = .scaleAspectFill
//    var loopMode: LottieLoopMode = .loop
//    var animationSpeed: CGFloat = 1.0
//    
//    var body: some View {
//        LottieView(animation: .named(filename))
//            .configure({ lottieAnimationView in
//                lottieAnimationView.contentMode = contentMode
//            })
//            .playbackMode(.playing(.toProgress(1, loopMode: loopMode)))
//            .animationSpeed(animationSpeed)
//    }
//    
////    func makeUIView(context: Context) -> UIView {
////        let view = UIView(frame: .zero)
////        let animationView = LottieAnimationView(name: filename)
////        animationView.frame = view.bounds
////        animationView.contentMode = .scaleAspectFit
////        animationView.loopMode = loopMode
////        animationView.animationSpeed = animationSpeed
////        animationView.play()
////        view.addSubview(animationView)
////        return view
////    }
//    
//}
//
//#Preview {
//    LottieViewHelper()
//}


import SwiftUI
import Lottie

struct LottieViewHelper: UIViewRepresentable {
    var filename: String = "loading.json"
    var contentMode: UIView.ContentMode = .scaleAspectFill
    var loopMode: LottieLoopMode = .loop
    var animationSpeed: CGFloat = 1.0

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update the view when needed
    }
}
