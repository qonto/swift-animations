//
//  PickerLayer.swift
//  MeetupAnimation
//
//  Created by charles on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class AnimatedLayer: CAShapeLayer, CALayerDelegate {

    override init() {
        super.init()
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return NSNull()
    }
}
