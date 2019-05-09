//
//  SecondToFirstTransition.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

private extension TimeInterval {
    static let delay: TimeInterval         = 0.2
    static let delayOffset: TimeInterval   = 0.2
    static let showDuration: TimeInterval  = 0.5
    static let hideDuration: TimeInterval  = 0.5
}

class SecondToFirstTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let animationDuration = 2 * .delay + .showDuration

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? SecondViewController else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) as? FirstViewController else { return }

        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)
        toViewController.view.backgroundColor = .clear

        toViewController.view.layoutIfNeeded()
        hideArrivalComponents(from: fromViewController)
        showSampleComponents(from: toViewController, completion: {
            toViewController.view.backgroundColor = .darkPurple
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func hideArrivalComponents(from secondViewController: SecondViewController) {
        Transition.hide(view: secondViewController.titleLabel, duration: .hideDuration)
        Transition.hide(view: secondViewController.subtitleLabel, duration: .hideDuration, delay: .delayOffset)
        Transition.hide(view: secondViewController.imageView, duration: .hideDuration, delay: .delayOffset)
    }

    private func showSampleComponents(from firstViewController: FirstViewController, completion: @escaping () -> Void) {
        Transition.show(view: firstViewController.titleLabel, duration: .showDuration, delay: .delayOffset)
        Transition.show(view: firstViewController.subtitleLabel, duration: .showDuration, delay: 2 * .delayOffset)
        Transition.show(view: firstViewController.amountLabel, duration: .showDuration, delay: 2 * .delayOffset)
        Transition.show(view: firstViewController.submitButton, duration: .showDuration, delay: 2 * .delayOffset, completion: { _ in
            completion()
        })
    }
}
