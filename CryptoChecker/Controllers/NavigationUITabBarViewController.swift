//
//  NavigationUITabBarViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class NavigationUITabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = UINavigationController(rootViewController: CryptocurrenciesViewController())
        let secondViewController = UINavigationController(rootViewController: WatchlistViewController())
        let thirdViewController = UINavigationController(rootViewController: NotificationsViewController())
        let fourthViewController = UINavigationController(rootViewController: ProfileViewController())
        

        firstViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "currencies"), tag: 1)
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "binoculars"), tag: 2)
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "notifications"), tag: 3)
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "profile"), tag: 4)
        
        
        let tabBarList = [ firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        let meme: UIView = {
            let returnView = UIView()
            returnView.backgroundColor = .red
            returnView.translatesAutoresizingMaskIntoConstraints = false
            
            
            return returnView
        }()
        
        view.addSubview(meme)
        
        NSLayoutConstraint.activate([
            meme.heightAnchor.constraint(equalToConstant: (self.view.frame.maxY - self.tabBar.frame.maxY)),
            meme.widthAnchor.constraint(equalToConstant: 50),
            meme.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            meme.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])
        
        let tabViewHeight = self.tabBar.frame.height
//        let imageHeight = firstViewController.tabBarItem.
        
        
        
        // TODO: Calculate offset for other devices aswell !
        

        let topOffset = CGFloat(5.0)
        
        for controller in tabBarList[1...] {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -topOffset, right: 0);
        }
        
        firstViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -topOffset+4, right: 0);
        
        viewControllers = tabBarList
        selectedViewController = thirdViewController
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
