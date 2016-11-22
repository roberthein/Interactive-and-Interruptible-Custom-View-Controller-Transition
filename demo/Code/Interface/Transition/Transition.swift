//
//  Transition.swift
//  demo
//
//  Created by Robert-Hein Hooijmans on 08/11/16.
//  Copyright © 2016 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

class Transition: NSObject {
    
    var animator: UIViewPropertyAnimator!
    var isInteractive: Bool { return context.isInteractive }
    
    private let operation: UINavigationControllerOperation
    private let context: UIViewControllerContextTransitioning
    private let panGesture: UIPanGestureRecognizer
    
    var scale: CGFloat = 0.7
    var translate: CGFloat {
        return context.containerView.bounds.width * 1.1
    }
    
    init(_ controllerOperation: UINavigationControllerOperation, _ transitionContext: UIViewControllerContextTransitioning, _ gestureRecognizer: UIPanGestureRecognizer) {
        self.operation = controllerOperation
        self.context = transitionContext
        self.panGesture = gestureRecognizer
        super.init()
        
        guard let fromViewController = context.viewController(forKey: .from) as? Transitionable else { return }
        guard let toViewController = context.viewController(forKey: .to) as? Transitionable else { return }
        guard let toView = toViewController.mainView() else { return }
        
        panGesture.addTarget(self, action: #selector(updateInteraction(with:)))
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(with:)))
        longPressGesture.minimumPressDuration = 0.0
        longPressGesture.cancelsTouchesInView = true
        toView.addGestureRecognizer(longPressGesture)
        
        switch operation {
        case .push:
            context.containerView.addSubview(toView)
            toViewController.stack()?.layer.transform = CATransform3DConcat(CATransform3DMakeScale(scale, scale, 1.0), CATransform3DMakeTranslation(translate, 0, 0))
            toViewController.gradient()?.alpha = 0
        case .pop:
            context.containerView.insertSubview(toView, at: 0)
            toViewController.stack()?.layer.transform = CATransform3DConcat(CATransform3DMakeScale(scale, scale, 1.0), CATransform3DMakeTranslation(-translate, 0, 0))
            fromViewController.gradient()?.alpha = 0
        default: return
        }
        
        configureAnimator(with: {
            toViewController.stack()?.layer.transform = CATransform3DIdentity
            
            switch self.operation {
            case .push:
                fromViewController.stack()?.layer.transform = CATransform3DConcat(CATransform3DMakeScale(self.scale, self.scale, 1.0), CATransform3DMakeTranslation(-self.translate, 0, 0))
            case .pop:
                fromViewController.stack()?.layer.transform = CATransform3DConcat(CATransform3DMakeScale(self.scale, self.scale, 1.0), CATransform3DMakeTranslation(self.translate, 0, 0))
            default: return
            }
            
        }, completion: { position in
            toView.removeGestureRecognizer(longPressGesture)
            toViewController.gradient()?.alpha = 1
            fromViewController.gradient()?.alpha = 1
        })
    }
    
    private func progressStepFor(translation: CGPoint) -> CGFloat {
        return (operation == .push ? -1.0 : 1.0) * translation.x / translate
    }
    
    func longPress(with gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            pauseAnimation()
        case .ended, .cancelled:
            endInteraction()
        default: break
        }
    }
    
    func configureAnimator(with animations: @escaping ()->(), completion: @escaping (UIViewAnimatingPosition)->()) {
        animator = UIViewPropertyAnimator(duration: Transition.duration(for: panVelocity), dampingRatio: 0.7, animations: animations)
        animator.addCompletion { [unowned self] (position) in
            completion(position)
            self.context.completeTransition(position == .end)
        }
    }
    
    func updateInteraction(with gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began, .changed:
            let translation = gesture.translation(in: gesture.view)
            let percentComplete = animator.fractionComplete + progressStepFor(translation: translation)
            
            animator.fractionComplete = percentComplete
            context.updateInteractiveTransition(percentComplete)
            
            gesture.setTranslation(.zero, in: gesture.view)
        case .ended, .cancelled:
            endInteraction()
        default: break
        }
    }
    
    func endInteraction() {
        guard isInteractive else { return }
        let targetPosition = self.targetPosition
        
        if targetPosition == .end {
            context.finishInteractiveTransition()
        } else {
            context.cancelInteractiveTransition()
        }
        
        animate(to: targetPosition)
    }
    
    var targetPosition: UIViewAnimatingPosition {
        
        let completionThreshold: CGFloat = 0.33
        let velocity = panGesture.velocity(in: panGesture.view).vector
        let isRightFlick = velocity.dx > 0.0
        let isLeftFlick = velocity.dx < 0.0
        
        if (operation == .push && isLeftFlick) || (operation == .pop && isRightFlick) {
            return .end
        } else if (operation == .push && isRightFlick) || (operation == .pop && isLeftFlick) {
            return .start
        } else if animator.fractionComplete > completionThreshold {
            return .end
        }
        
        return .start
    }
    
    var panVelocity: CGVector {
        let velocity = panGesture.velocity(in: panGesture.view)
        return CGVector(dx: velocity.x, dy: 0)
    }
    
    func animate(to position: UIViewAnimatingPosition) {
        animator.isReversed = position == .start
        
        if animator.state == .inactive {
            animator.startAnimation()
        } else {
            let durationFactor = CGFloat(Transition.duration(for: panVelocity) / animator.duration)
            animator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
        }
    }
    
    func pauseAnimation() {
        animator.pauseAnimation()
        context.pauseInteractiveTransition()
    }
    
    class func duration(for velocity: CGVector = .zero) -> TimeInterval {
        let spring = UISpringTimingParameters(mass: 3.0, stiffness: 1300, damping: 100, initialVelocity: velocity)
        let animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: spring)
        return animator.duration
    }
}
