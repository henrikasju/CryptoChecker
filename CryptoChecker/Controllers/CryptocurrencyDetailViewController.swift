//
//  CryptocurrencyDetailViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 27/11/2020.
//

import UIKit

class CryptocurrencyDetailViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
        button.setTitle("Action", for: .normal)
        
        return button
    }()
    
    let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.layer.cornerRadius = 3
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testView)
        view.addSubview(buttonView)
        buttonView.addSubview(button)
        button.addTarget(self, action: #selector(testFunc), for: .touchUpInside)
        
        view.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/3),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            
            button.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 20),
            
            testView.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -12),
            testView.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor)
        ])
        
    }
    
    @objc func testFunc(){
        print("Button pressed!")
        

        
        
//        view.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
//        view.frame.origin.x = 200
        var constraints: [NSLayoutConstraint.Attribute:NSLayoutConstraint] = [:]
        
        for constraint in view.constraints {
            var obj = constraint.firstItem!
            if obj.isEqual(buttonView) || obj.isEqual(button) || obj.isEqual(testView) {
                print("known obj")
            }else{
                if obj.isEqual(view) {
                    print(constraint.firstAnchor)
//                    print(constraint)
                    constraints[constraint.firstAttribute] = constraint
                }
            }
        }
        print(constraints.count)
        
        UIView.animate(withDuration: 3) {
            constraints[.width]?.constant = 50
            self.view.layoutIfNeeded()
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
