//
//  WaveButton.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class WaveButton: UIButton {

    // MARK: - Init

    private lazy var outCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.97, alpha:1.0)
        view.isHidden = true
        return view
    }()

    private lazy var inCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(red:0.23, green:0.22, blue:0.28, alpha:1.0)
        view.isHidden = true
        return view
    }()

    private lazy var myImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(imageName: String) {
        super.init(frame: .zero)

        addSubview(outCircle)
        addSubview(inCircle)
        addSubview(myImage)

        setupConstraints()

        myImage.image = UIImage(named: imageName)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            outCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            outCircle.topAnchor.constraint(equalTo: self.topAnchor),
            outCircle.heightAnchor.constraint(equalToConstant: 50),
            outCircle.widthAnchor.constraint(equalToConstant: 50),
            inCircle.centerXAnchor.constraint(equalTo: outCircle.centerXAnchor),
            inCircle.centerYAnchor.constraint(equalTo: outCircle.centerYAnchor),
            inCircle.heightAnchor.constraint(equalToConstant: 50),
            inCircle.widthAnchor.constraint(equalToConstant: 50),
            myImage.centerXAnchor.constraint(equalTo: outCircle.centerXAnchor),
            myImage.centerYAnchor.constraint(equalTo: outCircle.centerYAnchor)
        ])
    }

    func show() {
        outCircle.isHidden = false
        outCircle.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        inCircle.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)

        UIView.animate(withDuration: 0.3) {
            self.outCircle.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        }

        UIView.animate(withDuration: 0.10, delay: 0.20, options: [], animations: {
            self.inCircle.isHidden = false
            self.inCircle.transform = CGAffineTransform.identity
        }) { _ in
            self.outCircle.isHidden = true
            self.inCircle.isHidden = true
        }
    }

    @objc
    func handleTap() {
        show()
    }

}
