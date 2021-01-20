//
//  Lottie.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/20.
//

import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable{
    typealias UIViewType = UIView
    var fileName:String
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        animationView.animation = Animation.named(fileName)
//        animationView.backgroundColor(Color(red:231/255, green:216/255, blue:201/255))
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //do nothing
    }
}
