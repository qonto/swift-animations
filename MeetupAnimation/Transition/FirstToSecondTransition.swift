//
//  FirstToSecondTransition.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

private extension TimeInterval {
    static let delay: TimeInterval         = 0.2
    static let delayOffset: TimeInterval   = 0.2
    static let showDuration: TimeInterval  = 1.3
    static let hideDuration: TimeInterval  = 0.5
}

class FirstToSecondTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let animationDuration = 3 * .delay + .showDuration

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? FirstViewController else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) as? SecondViewController else { return }

        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)
        toViewController.view.backgroundColor = .clear

        toViewController.view.layoutIfNeeded()
        hideSampleComponents(from: fromViewController)
        showArrivalComponents(from: toViewController, completion: {
            toViewController.view.backgroundColor = .darkPurple
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func hideSampleComponents(from firstViewController: FirstViewController) {
        Transition.hide(view: firstViewController.titleLabel, duration: .hideDuration)
        Transition.hide(view: firstViewController.subtitleLabel, duration: .hideDuration, delay: .delayOffset)
        Transition.hide(view: firstViewController.amountLabel, duration: .hideDuration, delay: .delayOffset)
        Transition.hide(view: firstViewController.submitButton, duration: .hideDuration, delay: .delayOffset)
    }

    private func showArrivalComponents(from secondViewController: SecondViewController, completion: @escaping () -> Void) {
        Transition.showWithDamping(view: secondViewController.titleLabel, duration: .showDuration, delay: 2 * .delayOffset)
        Transition.showWithDamping(view: secondViewController.subtitleLabel, duration: .showDuration, delay: 3 * .delayOffset)
        Transition.showWithDamping(view: secondViewController.imageView, duration: .showDuration, delay: 3 * .delayOffset, completion: { _ in
            completion()
        })
    }
}
