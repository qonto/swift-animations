//
//  GiftBoxView.swift
//  MeetupAnimation
//
//  Created by Jianbin LIN on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit
import Lottie

class GiftBoxView: UIView {
    
    private struct Constants {
        
        static let maxOriginalProgress: CGFloat = 0.42
        static let minOriginalProgress: CGFloat = 0.2
        static let animationSpeed: CGFloat = 0.3
    }
    
    private let giftBox = AnimationView(name: "gift_box")
    private var currentProgress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLottieView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLottieView() {
        addSubview(giftBox)
        giftBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            giftBox.topAnchor.constraint(equalTo: topAnchor),
            giftBox.leftAnchor.constraint(equalTo: leftAnchor),
            giftBox.rightAnchor.constraint(equalTo: rightAnchor),
            giftBox.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    private func progressInOriginalAnimation(progress: CGFloat) -> CGFloat {
        return Constants.minOriginalProgress + (Constants.maxOriginalProgress - Constants.minOriginalProgress) * progress
    }
    
    private func normalizedProgress(progress: CGFloat) -> CGFloat {
        return min(max(progress, 0), 1)
    }
}

extension GiftBoxView {
    
    func play(progress: CGFloat) {
        giftBox.animationSpeed = Constants.animationSpeed
        let originalProgressValue = progressInOriginalAnimation(progress: normalizedProgress(progress: progress))
        if progress < currentProgress {
            giftBox.play(fromProgress: originalProgressValue + 0.02,
                         toProgress: originalProgressValue,
                         loopMode: LottieLoopMode.autoReverse,
                         completion: nil)
        } else {
            giftBox.play(fromProgress: originalProgressValue,
                         toProgress: originalProgressValue + 0.02,
                         loopMode: LottieLoopMode.autoReverse,
                         completion: nil)
        }
        currentProgress = progress
    }
}
