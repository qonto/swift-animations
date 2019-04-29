//
//  PickerSampleViewController.swift
//  MeetupAnimation
//
//  Created by charles on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class SliderSampleViewController: UIViewController {

    lazy var slider: Slider = {
        let slider = Slider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple
        
        view.addSubview(slider)
    }

    private func setupConstraints() {
        let sliderHeight: CGFloat = UIScreen.main.isNarrow ? 150 : 200

        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.widthAnchor.constraint(equalToConstant: sliderHeight),
            slider.heightAnchor.constraint(equalToConstant: sliderHeight)
            ])
    }
}
