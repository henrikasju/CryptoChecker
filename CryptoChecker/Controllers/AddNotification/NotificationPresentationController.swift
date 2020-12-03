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
    var childViewBottomConstraint: NSLayoutConstraint?
    
    var keyboardCurrentHeight: CGFloat = 0
    var keyboardDuration: Double?
    var keyboardCurve: UIView.AnimationCurve?
    private var firstLayoutSetup: Bool = true
    
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
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmingViewRecognizer.addTarget(self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(dimmingViewRecognizer)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)

        
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
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        NotificationCenter.default.removeObserver(self)
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
        
        if firstLayoutSetup {
            firstLayoutSetup = false
            
            
            mainChildView.translatesAutoresizingMaskIntoConstraints = false

            // TODO: Height multiplier should be calculated, some screens neeeds more space and horizontal position
            //       should be full screen!

//            childViewBottomConstraint = mainChildView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0)
            
            NSLayoutConstraint.activate([
                mainChildView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
                mainChildView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
    //            mainChildView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0),
//                childViewBottomConstraint!,
//                mainChildView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: keyboardCurrentHeight),
                mainChildView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1/2, constant: 0),
            ])

            mainChildView.layer.cornerRadius = 20
            mainChildView.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
            mainChildView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            mainChildView.clipsToBounds = true
            
        }else{
            print(keyboardCurrentHeight)
        }
    }
    
    override func containerViewDidLayoutSubviews() {
//        print(presentedView!.frame.height)
        presentedView!.frame.origin.y = presentedView!.frame.height
    }
    
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        if let transitioningDelegate = presentedViewController.transitioningDelegate as? NotificationTransitioningDelegate {
            presentedView?.endEditing(true)
            transitioningDelegate.transitionDirection = .toBottom
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let parentView = containerView,
              let childView = presentedView else { return }

        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        
        keyboardCurrentHeight = keyboardScreenEndFrame.height
        
//        print(notification.name)
//        print(parentView.frame.height, childView.frame.height, keyboardCurrentHeight)
//        print(parentView.safeAreaInsets)
//
//        print("[Parent] Before ", parentView.safeAreaInsets)
//        print("[Child] Before ", childView.safeAreaInsets)
        if notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
//            let keyboardViewEndFrame = parentView.convert(keyboardScreenEndFrame, from: parentView.window)
            
            keyboardCurrentHeight = keyboardScreenEndFrame.height
            
        }else if notification.name == UIResponder.keyboardWillHideNotification {
//            print("Will Hide!")
//            keyboardCurrentHeight = .zero
            
            //animate
//            UIView.animate(withDuration: 3) {
//                self.containerViewWillLayoutSubviews()
                childView.frame.origin.y = childView.frame.height
//                self.child?.frame.origin.y = 50
//            } completion: { _ in
////                self.containerViewDidLayoutSubviews()
//            }
            
        }else if notification.name == UIResponder.keyboardWillShowNotification {
//            print("Will Show!")
//            //animate
//            UIView.animate(withDuration: 3) {
//            childView.frame.origin.y -= self.keyboardCurrentHeight
            childView.frame.origin.y = parentView.frame.height - keyboardCurrentHeight - childView.frame.height
//            } completion: { _ in
////
//            }
        }
//        let childBottomInset = childView.safeAreaInsets.bottom
//        print("cBottom: ", childBottomInset, ". pBottom: ", parentView.safeAreaInsets.bottom)
        
        // TODO: Do research on safeAreas, creation, updating...
        if childView.safeAreaInsets.bottom == 0 {
            presentedViewController.additionalSafeAreaInsets.bottom = parentView.safeAreaInsets.bottom
        }else if childView.safeAreaInsets.bottom > parentView.safeAreaInsets.bottom{
            presentedViewController.additionalSafeAreaInsets.bottom = 0
        }
        
//        print("[Parent] After ", parentView.safeAreaInsets)
//        print("[Child] After ", childView.safeAreaInsets)
    }

}
