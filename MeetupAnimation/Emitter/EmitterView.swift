//
//  EmitterView.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 02/05/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit
import QuartzCore

class EmitterView: UIView {

    private lazy var emitter: CAEmitterLayer = {
        let emitter = layer as! CAEmitterLayer
        emitter.lifetime = 0.0
        return emitter
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterPosition = CGPoint(x: 0, y: 0)
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)

        let emitterCell = CAEmitterCell()

        emitterCell.contents = UIImage(named: "star.png")!.cgImage
        emitterCell.birthRate = 10
        emitterCell.lifetime = 10
        emitterCell.velocity = 80
        emitterCell.velocityRange = 250
        emitterCell.emissionRange = CGFloat(Double.pi / 2)
        emitterCell.emissionLongitude = CGFloat(Double.pi)
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.8
        emitterCell.scale = 0.5
        emitterCell.spin = CGFloat(1.5)
        emitterCell.spinRange = CGFloat(4.0)

        emitter.emitterCells = [emitterCell]
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }

    func start() {
        emitter.lifetime = 1
    }

    func stop() {
        emitter.lifetime = 0.0
    }
}
