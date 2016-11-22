//
//  TransitionController.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class TransitionController: NSObject {
    
    weak var navigationController: UINavigationController?
    
    var operation: UINavigationControllerOperation = .none
    var transition: Transition?
    var initiallyInteractive = false
    var panGesture: UIPanGestureRecognizer
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.panGesture = UIPanGestureRecognizer()
        super.init()
        
        panGesture.delegate = self
        panGesture.maximumNumberOfTouches = 1
        panGesture.addTarget(self, action: #selector(startTransition(with:)))
        navigationController.view.addGestureRecognizer(panGesture)
        navigationController.delegate = self
        
        guard let interactivePop = navigationController.interactivePopGestureRecognizer else { return }
        panGesture.require(toFail: interactivePop)
    }
    
    func startTransition(with gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began && transition == nil {
            
            let translation = gesture.translation(in: gesture.view)
            
            initiallyInteractive = true
            
            if translation.x < 0, let next = app?.router.next {
                app?.router.go(to: next)
            } else if translation.x > 0, let previous = app?.router.previous {
                app?.router.go(to: previous)
            }
        }
    }
}

extension TransitionController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let transition = self.transition else {
            let translation = panGesture.translation(in: panGesture.view)
            let translationIsHorizontal = abs(translation.x) > abs(translation.y)
            return translationIsHorizontal
        }
        
        return transition.isInteractive
    }
}

extension TransitionController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self
    }
}

extension TransitionController: UIViewControllerInteractiveTransitioning {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        transition = Transition(operation, transitionContext, panGesture)
    }
    
    var wantsInteractiveStart: Bool {
        return initiallyInteractive
    }
}

extension TransitionController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}
    
    func animationEnded(_ transitionCompleted: Bool) {
        transition = nil
        initiallyInteractive = false
        operation = .none
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return (transition?.animator)!
    }
}
