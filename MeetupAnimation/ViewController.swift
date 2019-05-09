//
//  ViewController.swift
//  MeetupAnimation
//
//  Created by charles on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    enum Sample: String, CaseIterable {
        case button     = "✅ Button sample"
        case emitter    = "✨ Emitter sample"
        case transition = "📱 Transition sample"
        case slider     = "🧙‍♂️ Slider sample"
        case lottie     = "🎁 Lottie sample"
        case final      = "🥳 Final sample"
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        setupConstraints()
    }

    private func setupInterface() {
        view.backgroundColor = .darkPurple
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sample.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

        cell.textLabel?.text = Sample.allCases[indexPath.row].rawValue
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 20)
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sample = Sample.allCases[indexPath.row]

        var viewController: UIViewController
        switch sample {
        case .button:
            viewController = ButtonsViewController()
        case .emitter:
            viewController = EmitterViewController()
        case .transition:
            viewController = FirstViewController()
        case .slider:
            viewController = SliderSampleViewController()
        case .lottie:
            viewController = LottieSampleViewController()
        case .final:
            viewController = FirstFinalViewController()
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

