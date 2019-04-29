//
//  NavigationController.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

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
        case is (TransitionSampleViewController, TransitionArrivalViewController):
            if operation == .push {
                return SampleToArrivalTransition()
            }
        case is (TransitionArrivalViewController, TransitionSampleViewController):
            if operation == .pop {
                return ArrivalToSampleTransition()
            }
        case is (FinalSampleViewController, TransitionArrivalViewController):
            if operation == .push {
                return FinalSampleToArrivalTransition()
            }
        case is (TransitionArrivalViewController, FinalSampleViewController):
            if operation == .pop {
                return ArrivalToFinalSampleTransition()
            }
        default:
            return nil
        }
        return nil
    }

}
