//
//  NotificationTransitioningDelegate.swift
//  CryptoChecker
//
//  Created by Henrikas J on 26/11/2020.
//

import UIKit

enum PresentationDirection {
  case toLeft
  case fromTop
  case toRight
  case fromBottom
}

class NotificationTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var transitionDirection: PresentationDirection = .fromBottom
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = NotificationPresentationController(presentedViewController: presented, presenting: presenting, direction: transitionDirection)
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NotificationAnimatedTransitioning(direction: transitionDirection, presentViewController: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NotificationAnimatedTransitioning(direction: transitionDirection, presentViewController: false)
    }

}
