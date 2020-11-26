//
//  NotificationPresentationController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 26/11/2020.
//

import UIKit

class NotificationPresentationController: UIPresentationController {
    
    private var direction: PresentationDirection
    var minDimmingAlpha: CGFloat = 0.0
    var maxDimmingAlpha: CGFloat = 0.35
    
    let dimmingViewRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        
        return recognizer
    }()
    
    private let dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.0
        
        return view
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmingViewRecognizer.addTarget(self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(dimmingViewRecognizer)
    }
    
    override func presentationTransitionWillBegin() {
        
        guard let parentView = containerView else{
            fatalError("Could not get parent view in NotificationPresentationController")
        }
        parentView.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: parentView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
        ])
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            fatalError("Could not get child view controllers transition coordinator!")
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = self.maxDimmingAlpha
        }, completion: nil)

    }
    
    override func dismissalTransitionWillBegin() {
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            fatalError("Could not get child view controllers transition coordinator!")
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = self.minDimmingAlpha
        }, completion: nil)
        
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let mainChildView = presentedView, let parentView = containerView else{
            fatalError("Could not setup custom presentation in notification creation!")
        }
        
        mainChildView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(testView)
                
        NSLayoutConstraint.activate([
            mainChildView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            mainChildView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            mainChildView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0),
            mainChildView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1/2, constant: 0),
            
            testView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            testView.widthAnchor.constraint(equalToConstant: 50),
            testView.heightAnchor.constraint(equalToConstant: 5),
            testView.bottomAnchor.constraint(equalTo: mainChildView.topAnchor, constant: -12),
        ])
                
        mainChildView.layer.cornerRadius = 20
        mainChildView.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        mainChildView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainChildView.clipsToBounds = true
    }
    
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        if let transitioningDelegate = presentedViewController.transitioningDelegate as? NotificationTransitioningDelegate {
            transitioningDelegate.transitionDirection = .toLeft
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    


}
