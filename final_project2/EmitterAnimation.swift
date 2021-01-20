//
//  EmitterAnimation.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/6.
//
import SwiftUI

struct EmitterLayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let snowEmitterCell = CAEmitterCell()
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterCell.contents = UIImage(named: "tableware")?.cgImage
        snowEmitterCell.birthRate = 1
        snowEmitterCell.lifetime = 2
        snowEmitterCell.velocity = 100
        snowEmitterCell.lifetime = 20
        snowEmitterCell.yAcceleration = 30
        snowEmitterCell.scale = 0.01
        snowEmitterCell.scaleRange = 0.03
        snowEmitterCell.scaleSpeed = -0.02
        snowEmitterCell.spin = 0.5
        snowEmitterCell.spinRange = 1
        snowEmitterCell.emissionRange = CGFloat.pi
        
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = .line
        snowEmitterLayer.scale = 2
        snowEmitterLayer.birthRate = 2
        snowEmitterLayer.emitterCells = [snowEmitterCell]
        view.layer.addSublayer(snowEmitterLayer)

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    typealias UIViewType = UIView
}
