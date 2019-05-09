//
//  SecondViewController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var isFinalDemo = false

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 32.0)
        label.text = "Great !"
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = "Thank you. We'll inform you soon about the next steps to follow."
       label.font = UIFont(name: "Helvetica", size: 16.0)
        label.textAlignment = .center
        return label
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "success")
        return view
    }()

    private lazy var emitterView: EmitterView = {
        let view = EmitterView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        guard isFinalDemo == true else { return }

        self.emitterView.start()
        UIView.animate(withDuration: 0.5, animations: {
            self.emitterView.alpha = 1
        }, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIView.animate(withDuration: 0.5, animations: {
            self.emitterView.alpha = 0
        }, completion: { _ in
            self.emitterView.stop()
        })
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(imageView)
        view.addSubview(emitterView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),

            emitterView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            emitterView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

}
