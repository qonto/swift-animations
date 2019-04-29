//
//  TransitionSampleViewController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class TransitionSampleViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 32.0)
        label.text = "Hi John !"
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = "You're about to transfer this amount to Jane. If you approve it, please tap submit"
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.textAlignment = .center
        return label
    }()

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = "250$"
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        return label
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .pink
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return button
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
        view.addSubview(amountLabel)
        view.addSubview(submitButton)

        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 200),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

    @objc
    func submitButtonPressed() {
        let viewController = TransitionArrivalViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
