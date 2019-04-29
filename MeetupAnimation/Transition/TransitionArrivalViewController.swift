//
//  TransitionArrivalViewController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class TransitionArrivalViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50)
            ])
    }

}
