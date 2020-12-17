//
//  NotificationsViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    var tableViewTopConstraint: NSLayoutConstraint?
    
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
        
        tableView.separatorStyle = .none
        tableView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        tableView.showsVerticalScrollIndicator = false
        tableView.selectionFollowsFocus = false
        
        return tableView
    }()
    
    let helperLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Currently, there are no notifications set!"
        label.textColor = .darkGray
        
        return label
    }()
    
    var addNotificationTransitioningDelegate = NotificationTransitioningDelegate()
    var showAllCurrencies: Bool = true
    var currenciesWithNotifications: [Cryptocurrency] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showAllCurrencies {
            navigationController?.isNavigationBarHidden = true
            
            currenciesWithNotifications = DataBaseManager.shareInstance.fetchCryptocurrenciesWithNotifications()
        }else{
            navigationController?.isNavigationBarHidden = false
        }
        
        if showAllCurrencies && currenciesWithNotifications.count <= 0 {
            setupHelperLabelView()
        }else if showAllCurrencies && currenciesWithNotifications.count > 0 && view.subviews.contains(helperLabel) {
            helperLabel.removeFromSuperview()
        }
        
        // TODO: Optimize!
        notificationTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.AppColors.appBackground
        
        notificationTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        notificationTableView.register(NotificationTableViewBottomCell.self, forCellReuseIdentifier: NotificationTableViewBottomCell.identifier)
        notificationTableView.register(NotificationTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationTableViewHeaderView.identifier)
        
        
        view.addSubview(viewTitle)
        view.addSubview(notificationTableView)
        
        setupTitleLabel()
        setupTableView()
        
    }
    
    private func setupHelperLabelView() {
        view.addSubview(helperLabel)
        
        NSLayoutConstraint.activate([
            helperLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            helperLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
    }
    
    private func setupTitleLabel(){
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupTableView(){
        let sidePadding: CGFloat = 16
        
        
        
        if showAllCurrencies {
            tableViewTopConstraint = notificationTableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 49)
        }else{
            tableViewTopConstraint = notificationTableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8)
        }
        
        tableViewTopConstraint?.isActive = true
        notificationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sidePadding).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return currenciesWithNotifications.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesWithNotifications[section].notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currenciesWithNotifications[section].notifications.count == 0 {
            return 50
        }
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
        
        if currenciesWithNotifications[section].notifications.count == 0 {
//            returnView.contentView.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
            returnView.contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        }else if returnView.contentView.layer.maskedCorners.contains(.layerMinXMaxYCorner) && returnView.contentView.layer.maskedCorners.contains(.layerMaxXMaxYCorner) {
            
            returnView.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let selectedData = currenciesWithNotifications[indexPath.section]
            // Checking if deleting cell is last in section
            if selectedData.notifications.count >= 1 {
                selectedData.notifications.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if let senderIndex = indexPath, currenciesWithNotifications.count > 0 {
            
            let lastRow = (currenciesWithNotifications[senderIndex.section].notifications.count - 1)
            // if sender row is higher than data count, then that cell has been deleted
            // need to apply rounded corners to last cell
            if lastRow >= 0 && senderIndex.row > lastRow {
                let lastCellIndex = IndexPath(row: lastRow, section: senderIndex.section)
                tableView.reloadRows(at: [lastCellIndex], with: .none)
            }else if lastRow < 0 && showAllCurrencies {
                currenciesWithNotifications.remove(at: senderIndex.section)
                tableView.deleteSections(IndexSet(arrayLiteral: senderIndex.section), with: .fade)
                
                if currenciesWithNotifications.count <= 0 && !view.subviews.contains(helperLabel){
                    setupHelperLabelView()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = currenciesWithNotifications[indexPath.section]
        let selectedNotification = selectedData.notifications[indexPath.row]
        
        let vc = AddNotificationViewController()
        addNotificationTransitioningDelegate.transitionDirection = .fromBottom
        vc.transitioningDelegate = addNotificationTransitioningDelegate
        vc.modalPresentationStyle = .custom
        
        vc.delegate = self
        vc.data = selectedData
        vc.editMode = true
        vc.editData = selectedNotification
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

//MARK: - Table view cell Section
extension NotificationsViewController: NotificationTableViewCellDelegate{
    func notificationStatusChanged(_ tableViewCell: NotificationTableViewCell, uiSwitch: UISwitch) {
        
        // TODO: Prob check before accessing array element
        if let tableCellIndex = notificationTableView.indexPath(for: tableViewCell){
            currenciesWithNotifications[tableCellIndex.section].notifications[tableCellIndex.row].isOn = uiSwitch.isOn
        }
    }
}

//MARK: - Table view header Section
extension NotificationsViewController: NotificationTableViewHeaderViewDelegate{
    
    func notificationAddButtonPressed(tableViewHeaderView: NotificationTableViewHeaderView, button: UIButton) {
                
        let vc = AddNotificationViewController()
        addNotificationTransitioningDelegate.transitionDirection = .fromBottom
        vc.transitioningDelegate = addNotificationTransitioningDelegate
        vc.modalPresentationStyle = .custom
        
        vc.delegate = self
        vc.data = currenciesWithNotifications[tableViewHeaderView.id]
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

extension NotificationsViewController: AddNotificationViewControllerDelegate{
    
    func AddNotificationPopUpViewWillDisapear(_ viewController: AddNotificationViewController, animated: Bool) {
        self.viewWillAppear(animated)
    }
}
