//
//  FirstFinalViewController.swift
//  MeetupAnimation
//
//  Created by charles on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class FirstFinalViewController: UIViewController {

    lazy var giftBoxView: GiftBoxView = {
        let view = GiftBoxView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Make a gift:"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .pastelPurple
        return label
    }()

    lazy var progressText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.textColor = .white
        return label
    }()

    lazy var slider: Slider = {
        let slider = Slider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.delegate = self
        return slider
    }()

    lazy var plusButton: WaveButton = {
        let button = WaveButton(imageName: "ic_plus")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var minusButton: WaveButton = {
        let button = WaveButton(imageName: "ic_minus")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var checkButton: CheckButton = {
        let button = CheckButton(imageName: "ic_check")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple

        view.addSubview(giftBoxView)
        view.addSubview(titleLabel)
        view.addSubview(progressText)
        view.addSubview(slider)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(checkButton)

        updateProgressText()
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        let giftBoxHeight: CGFloat = UIScreen.main.isNarrow ? 130 : 180
        let sliderHeight: CGFloat = UIScreen.main.isNarrow ? 150 : 200

        NSLayoutConstraint.activate([
            giftBoxView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5),
            giftBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            giftBoxView.heightAnchor.constraint(equalToConstant: giftBoxHeight),
            giftBoxView.widthAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: giftBoxView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            progressText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            progressText.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.widthAnchor.constraint(equalToConstant: sliderHeight),
            slider.heightAnchor.constraint(equalToConstant: sliderHeight),
            slider.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -80),

            plusButton.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 5),
            plusButton.topAnchor.constraint(equalTo: slider.topAnchor, constant: -15),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),

            minusButton.leadingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -15),
            minusButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),

            checkButton.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            checkButton.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            checkButton.widthAnchor.constraint(equalToConstant: 50)
            ])
    }

    fileprivate func updateProgressText() {
        let amount = Int(slider.progress * 100)
        progressText.text = "\(amount) €"
    }

    @objc
    func checkButtonPressed() {
        checkButton.hide {
            let viewController = SecondViewController()
            viewController.isFinalDemo = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    @objc
    func plusButtonPressed() {
        let newAmount = min((slider.progress * 100) + 1, 100)
        let newProgress: CGFloat = newAmount / 100
        slider.slide(to: newProgress, animated: true)
    }

    @objc
    func minusButtonPressed() {
        let newAmount = max((slider.progress * 100) - 1, 0)
        let newProgress: CGFloat = newAmount / 100
        slider.slide(to: newProgress, animated: true)
    }

}

extension FirstFinalViewController: SliderDelegate {

    func sliderValueChanged(_ sender: Slider) {
        updateProgressText()
        giftBoxView.play(progress: slider.progress)
    }
}
