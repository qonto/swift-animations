//
//  Transition.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class Transition {

    static func hide(view: UIView, duration: TimeInterval, delay: TimeInterval = 0, needTranslate: Bool = true, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            view.alpha = 0
            view.transform = needTranslate ? CGAffineTransform(translationX: 0, y: 40) : .identity
        }, completion: completion)
    }

    static func show(view: UIView, duration: TimeInterval, delay: TimeInterval = 0, needTranslate: Bool = true, completion: ((Bool) -> Void)? = nil) {
        view.alpha = 0
        view.transform = needTranslate ? CGAffineTransform(translationX: 0, y: 40) : .identity

        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            view.alpha = 1
            view.transform = .identity
        }, completion: completion)
    }
}
