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
    
//    let headerHeight: CGFloat = 30
//    let footerHeight: CGFloat = 30
//    let sectionEdgeHeight: CGFloat = 30 * 0.9
//    let sectionCornerRadius: CGFloat = 20
    
    private var currenciesWithNotifications: [Cryptocurrency] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        currenciesWithNotifications = DataBaseManager.shareInstance.fetchCryptocurrenciesWithNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.AppColors.appBackground
        
        notificationTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        notificationTableView.register(NotificationTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationTableViewHeaderView.identifier)
        
        notificationTableView.separatorStyle = .none
        notificationTableView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        
        
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
        notificationTableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
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
        return 60
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: notificationTableView.frame.width, height: 60))
//        let topView = UIView(frame: CGRect(x: 0, y: 0, width: mainView.frame.width, height: 35))
//
//        topView.layer.cornerRadius = 20
//        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//
//        mainView.backgroundColor = .none
//        topView.backgroundColor = .white
//
//
//        mainView.addSubview(topView)
//
//        return mainView
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationTableViewHeaderView.identifier) as! NotificationTableViewHeaderView
        
        
        
        return returnView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell else{
            fatalError("[CollectionView] - could't deque cell")
        }
        
        let currencyIndex: Int = indexPath.section
        let notificationIndex: Int = indexPath.row
        let notification = currenciesWithNotifications[currencyIndex].notifications[notificationIndex]
        let lastCell: Bool = ( notificationIndex == (currenciesWithNotifications[currencyIndex].notifications.count - 1) ? true : false)
        
        cell.updateFieldWithData(data: notification, lastCell: lastCell)
        
        return cell
    }
    
    
}
