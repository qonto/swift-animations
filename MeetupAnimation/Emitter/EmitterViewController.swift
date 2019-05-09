//
//  EmitterViewController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 02/05/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class EmitterViewController: UIViewController {

    private lazy var emitterView: EmitterView = {
        let view = EmitterView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        emitterView.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        emitterView.stop()
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple

        view.addSubview(emitterView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emitterView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            emitterView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

}
