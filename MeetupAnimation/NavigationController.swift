//
//  NavigationController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        // Setup navigationBar
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
}

extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch (fromVC, toVC) {
        case is (FirstViewController, SecondViewController):
            if operation == .push {
                return FirstToSecondTransition()
            }
        case is (SecondViewController, FirstViewController):
            if operation == .pop {
                return SecondToFirstTransition()
            }
        case is (FirstFinalViewController, SecondViewController):
            if operation == .push {
                return FirstToSecondFinalTransition()
            }
        case is (SecondViewController, FirstFinalViewController):
            if operation == .pop {
                return SecondToFirstFinalTransition()
            }
        default:
            return nil
        }
        return nil
    }

}
