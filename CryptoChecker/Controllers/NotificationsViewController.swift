//
//  NotificationsViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class NotificationsViewController: UIViewController {

    let viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notifications"
        label.font = Constants.CryptoCurrenciesController.Fonts.viewTitle
        return label
    }()
    
    lazy var notificationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .none
        return tableView
    }()
    
    var addNotificationTransitioningDelegate = NotificationTransitioningDelegate()
    
    private var currenciesWithNotifications: [Cryptocurrency] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        currenciesWithNotifications = DataBaseManager.shareInstance.fetchCryptocurrenciesWithNotifications()
        currenciesWithNotifications.append(contentsOf: currenciesWithNotifications)
        currenciesWithNotifications.append(contentsOf: currenciesWithNotifications)
        currenciesWithNotifications.append(contentsOf: currenciesWithNotifications)
        currenciesWithNotifications.append(contentsOf: currenciesWithNotifications)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.AppColors.appBackground
        
        notificationTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        notificationTableView.register(NotificationTableViewBottomCell.self, forCellReuseIdentifier: NotificationTableViewBottomCell.identifier)
        notificationTableView.register(NotificationTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationTableViewHeaderView.identifier)
        
        notificationTableView.separatorStyle = .none
        notificationTableView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        notificationTableView.showsVerticalScrollIndicator = false
        
        
        view.addSubview(viewTitle)
        view.addSubview(notificationTableView)
        
        setupTitleLabel()
        setupTableView()
        
        notificationTableView.selectionFollowsFocus = false
    }
    
    private func setupTitleLabel(){
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupTableView(){
        let sidePadding: CGFloat = 16
        notificationTableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 49).isActive = true
        notificationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sidePadding).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
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

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return currenciesWithNotifications.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesWithNotifications[section].notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnView: UIView = {
            let view = UIView()
            view.backgroundColor = .none
            return view
        }()
        return returnView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // TODO: OPTIMIZE!!!!!!
        
        let returnView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationTableViewHeaderView.identifier) as! NotificationTableViewHeaderView
        
        returnView.updateFieldWithData(data: currenciesWithNotifications[section], sectionId: section)
        
        if returnView.delegate == nil {
            returnView.delegate = self
        }
        
//        let lol = NotificationTableViewHeaderView()
//        lol.updateFieldWithData(data: currenciesWithNotifications[section])
        
//        let lol = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
//        lol.backgroundColor = .red
        
        return returnView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NotificationTableViewCell?
        
        let currencyIndex: Int = indexPath.section
        let notificationIndex: Int = indexPath.row
        let notifications = currenciesWithNotifications[currencyIndex].notifications
        
        if notificationIndex == notifications.count-1 {
            // Bottom(Last) Cell
            guard let bottomCell = (tableView.dequeueReusableCell(withIdentifier: NotificationTableViewBottomCell.identifier, for: indexPath) as? NotificationTableViewBottomCell) else{
                fatalError("[CollectionView] - could't deque bottom cell")
            }
            
            cell = bottomCell
        }else{
            // Top or middle Cell
            guard let middleCell = (tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell) else{
                fatalError("[CollectionView] - could't deque middle cell")
            }
            
            cell = middleCell
        }
        
        // TODO: Fix needs better solution, has a bug on scroll!
        cell!.updateFieldWithData(data: notifications[notificationIndex])
        if cell?.delegate == nil {
            cell?.delegate = self
        }
        
        
        return cell!
    }
    
    
}

//MARK: - Table view cell Section
extension NotificationsViewController: NotificationTableViewCellDelegate{
    func notificationStatusChanged(_ tableViewCell: NotificationTableViewCell, switch: UISwitch) {
        print("Notification changed - controller")
    }
}

//MARK: - Table view header Section
extension NotificationsViewController: NotificationTableViewHeaderViewDelegate{
    
    func notificationAddButtonPressed(tableViewHeaderView: NotificationTableViewHeaderView, button: UIButton) {
        print("Add pressed - controller")
        
//        var idk = tableViewHeaderView
        
        var vc = AddNotificationViewController()
//        vc.setNavi = self.navigationController
        addNotificationTransitioningDelegate.transitionDirection = .fromBottom
        vc.transitioningDelegate = addNotificationTransitioningDelegate
        vc.modalPresentationStyle = .custom
        vc.data = currenciesWithNotifications[tableViewHeaderView.id]
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
