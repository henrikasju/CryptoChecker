//
//  AddNotificationViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 20/11/2020.
//

import UIKit

class AddNotificationViewController: UIViewController {
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
        
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOL", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed(sender:)))
        let navigationItem = UINavigationItem(title: "Cryptocurrency")
        navigationItem.leftBarButtonItem = leftBarButton
        
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        
        bar.setItems([navigationItem], animated: false)
        
        return bar
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    let testTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cyan
        textField.placeholder = "LOL"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(view.frame)
        print(view.bounds)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.AppColors.appBackground
        view.addSubview(navigationBar)
        view.addSubview(button)
        
//        view.addSubview(testView)
        view.addSubview(testTextField)
        
        print(view.frame)
        print(view.bounds)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
//            testView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            testView.heightAnchor.constraint(equalToConstant: 5),
//            testView.widthAnchor.constraint(equalToConstant: 50),
//            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            testTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testTextField.heightAnchor.constraint(equalToConstant: 40),
            testTextField.widthAnchor.constraint(equalToConstant: 100),
        ])
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: nil)
        
    }
    
    @objc func cancelButtonPressed(sender: UIButton){
        print(view.frame)
        print(view.bounds)

        if let transitioningDelegate = self.transitioningDelegate as? NotificationTransitioningDelegate{
            transitioningDelegate.transitionDirection = .toLeft
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func buttonPressed(sender: UIButton){
        print(view.frame)
        print(view.bounds)
        
        if let transitioningDelegate = self.transitioningDelegate as? NotificationTransitioningDelegate{
            transitioningDelegate.transitionDirection = .fromTop
            dismiss(animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
