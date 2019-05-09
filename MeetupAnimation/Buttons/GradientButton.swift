//
//  GradientButton.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 02/05/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class GradientButton: UIView {

    private var text: String!

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = UIColor.white
        return label
    }()

    // MARK: - Init

    init(text: String) {
        super.init(frame: .zero)
        self.text = text

        addSubview(label)

        setupConstraints()
        setupInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }

    private func setupInterface() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 25
        backgroundColor = .purple

        label.text = text
    }

    func startAnimation() {
        label.startShimmering()
    }

    func stopAnimation() {
        label.stopShimmering()
    }

}

extension UIView {
    func startShimmering() {
        let solid = UIColor(white: 1, alpha: 1.0).cgColor
        let clear = UIColor(white: 1, alpha: 0.7).cgColor

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [clear, solid, clear]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.53)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient

        let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]

        animation.duration = 1.5
        animation.repeatCount = Float.greatestFiniteMagnitude
        gradient.add(animation, forKey: nil)
    }

    func stopShimmering() {
        self.layer.mask = nil
    }

}
