//
//  NotificationAnimatedTransitioning.swift
//  CryptoChecker
//
//  Created by Henrikas J on 26/11/2020.
//

import UIKit

class NotificationAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    let direction: PresentationDirection
    let presentViewController: Bool
    
    init(direction: PresentationDirection, presentViewController: Bool) {
        self.direction = direction
        self.presentViewController = presentViewController
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let key: UITransitionContextViewControllerKey = presentViewController ? .to : .from
        
        guard let controller = transitionContext.viewController(forKey: key) else {
            fatalError("Could not get controller from transistinoContext in NotificationAnimatedTransitioning")
        }
        
        if presentViewController {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        switch direction {
        case .fromBottom:
            dismissedFrame.origin.y = presentedFrame.height
        case .fromTop:
            dismissedFrame.origin.y = -presentedFrame.height
        case .toLeft:
            dismissedFrame.origin.x = -presentedFrame.width
        case .toRight:
            dismissedFrame.origin.x = presentedFrame.width
//        default:
//            dismissedFrame.origin.y = -presentedFrame.height
        }
        
        let initialFrame = presentViewController ? dismissedFrame : presentedFrame
        let finalFrame = presentViewController ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration) {
            controller.view.frame = finalFrame
        } completion: { (finished) in
            if !self.presentViewController {
                controller.view.removeFromSuperview()
            }
            transitionContext.completeTransition(finished)
        }

        
        
    }
    
    
}
