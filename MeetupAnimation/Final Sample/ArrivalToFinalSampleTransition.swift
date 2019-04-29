//
//  ArrivalToFinalSampleTransition.swift
//  MeetupAnimation
//
//  Created by Marine Commercon on 24/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

private extension TimeInterval {
    static let durationRatio: TimeInterval = 0.8
    static let delay: TimeInterval         = 0.30 * .durationRatio
    static let delayOffset: TimeInterval   = 0.08 * .durationRatio
    static let showDuration: TimeInterval  = 0.45 * .durationRatio
    static let hideDuration: TimeInterval  = 0.45 * .durationRatio
}

class ArrivalToFinalSampleTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let animationDuration = .delay + .showDuration

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? TransitionArrivalViewController else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) as? FinalSampleViewController else { return }

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

    private func hideArrivalComponents(from transitionArrivalViewController: TransitionArrivalViewController) {
        Transition.hide(view: transitionArrivalViewController.titleLabel, duration: .hideDuration)
        Transition.hide(view: transitionArrivalViewController.subtitleLabel, duration: .hideDuration, delay: .delayOffset)
        Transition.hide(view: transitionArrivalViewController.imageView, duration: .hideDuration, delay: .delayOffset)
    }

    private func showSampleComponents(from finalSampleViewController: FinalSampleViewController, completion: @escaping () -> Void) {
        Transition.show(view: finalSampleViewController.giftBoxView, duration: .hideDuration)
        Transition.show(view: finalSampleViewController.titleLabel, duration: .hideDuration, delay: .delayOffset)
        Transition.show(view: finalSampleViewController.progressText, duration: .hideDuration, delay: 2 * .delayOffset)
        Transition.show(view: finalSampleViewController.slider, duration: .hideDuration, delay: 2 * .delayOffset, completion: { _ in
            finalSampleViewController.checkButton.show()
            completion()
        })
    }
}
