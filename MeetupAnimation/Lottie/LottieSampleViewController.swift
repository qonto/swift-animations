//
//  LottieSampleViewController.swift
//  MeetupAnimation
//
//  Created by Jianbin LIN on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class LottieSampleViewController: UIViewController {

    private lazy var giftBoxView: GiftBoxView = {
        let view = GiftBoxView()
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: [.valueChanged])
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var progressText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
    }
    
    private func setupInterface() {
        view.backgroundColor = .darkPurple
        view.addSubview(slider)
        
        // Progress text
        view.addSubview(progressText)
        updateProgressText()
        
        view.addSubview(giftBoxView)
    }
    
    private func setupConstraints() {
        setupSliderConstraints()
        setupProgressTextConstraints()
        setupGiftBoxViewConstraints()
        setupInterViewsConstraints()
    }
    
    private func setupSliderConstraints() {
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60)
            ])
    }
    
    private func setupProgressTextConstraints() {
        NSLayoutConstraint.activate([
            progressText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            ])
    }
    
    private func setupGiftBoxViewConstraints() {
        let giftBoxHeight: CGFloat = UIScreen.main.isNarrow ? 130 : 180

        NSLayoutConstraint.activate([
            giftBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            giftBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            giftBoxView.heightAnchor.constraint(equalToConstant: giftBoxHeight),
            giftBoxView.widthAnchor.constraint(equalToConstant: 300)
            ])
    }

    private func setupInterViewsConstraints() {
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: giftBoxView.bottomAnchor, constant: 30),
            progressText.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 30)
            ])
    }
    
    private func updateProgressText() {
        progressText.text = "Progress: \(slider.value)"
    }
}

// MARK: Action handlers
extension LottieSampleViewController {
    
    @objc func sliderValueChanged(_ sender: Any) {
        updateProgressText()
        giftBoxView.play(progress: CGFloat(slider.value))
    }
}
