//
//  ButtonsViewController.swift
//  MeetupAnimation
//
//  Created by charles on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {

    private lazy var checkButton: CheckButton = {
        let button = CheckButton(imageName: "ic_check")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var waveButton: WaveButton = {
        let button = WaveButton(imageName: "ic_plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple

        view.addSubview(checkButton)
        view.addSubview(waveButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            checkButton.widthAnchor.constraint(equalToConstant: 50),

            waveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            waveButton.heightAnchor.constraint(equalToConstant: 50),
            waveButton.widthAnchor.constraint(equalToConstant: 50)
            ])
    }

    @objc
    func handleTap() {
        checkButton.show()
    }

    @objc
    func checkButtonPressed() {
        checkButton.hide()
    }

}

