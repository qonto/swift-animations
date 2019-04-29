//
//  CheckButton.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class CheckButton: UIButton {

    // MARK: - Init

    init(imageName: String) {
        super.init(frame: .zero)

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 25
        backgroundColor = UIColor(red:0.40, green:0.87, blue:0.59, alpha:1.0)
        setImage(UIImage(named: imageName), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func hide(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { _ in
                completion?()
            })
        }
    }

    func show() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }

}
