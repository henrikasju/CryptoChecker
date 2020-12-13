//
//  ProfileViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Notification Switch vibrates when selected, do same vibration for text based option selection

class PreferencesViewController: UIViewController {

    let viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Preferences"
        label.font = Constants.CryptoCurrenciesController.Fonts.viewTitle
        return label
    }()
    
    lazy var preferencesCollectionView: CryptocurrenciesUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = CryptocurrenciesUICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    // TODO: Remove HardCode! PreferenceSwitchBased
    
    var switchBasedPreferences: [ (value: PreferenceSwitchBased, closure: (Bool) -> ())] = [
        (PreferenceSwitchBased(title: "Notifications", onStatus: true), UserDefaultsManager.setUserGlobalNotificationStatus(isOn: )),
    ]
    
    var textBasedPreferences: [ (values: PreferenceTextBased, updateClosure: (String) -> () )] = [
        (PreferenceTextBased(title: "Data Format",
                            options: [
                                    PreferenceTextBased.Option(title: "DD-MM-YYYY", selected: false),
                                PreferenceTextBased.Option(title: "YYYY-MM-DD", selected: false),
                                    PreferenceTextBased.Option(title: "MM-DD-YY", selected: false),
                            ]), UserDefaultsManager.setDataFormat(dataFormat:)),
        (PreferenceTextBased(title: "Time Format",
                            options: [
                                    PreferenceTextBased.Option(title: "24 Hours", selected: false),
                                    PreferenceTextBased.Option(title: "12 Hours", selected: false),
                            ]), UserDefaultsManager.setTimeFormat(timeFormat:)),
        (PreferenceTextBased(title: "Fiat Currency",
                            options: [
                                    PreferenceTextBased.Option(title: "Yen", selected: false),
                                    PreferenceTextBased.Option(title: "Euro", selected: false),
                                    PreferenceTextBased.Option(title: "USD", selected: false),
                            ]), UserDefaultsManager.setFiatCurrency(fiatCurrency:)),
    ]
    
    var firstViewLoad: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        navigationController?.isNavigationBarHidden = true
        
        // TODO: Update with DB!
        // Updating Preference selections
        // Global Notifications
        switchBasedPreferences[0].value.onStatus = UserDefaultsManager.getUserGlobalNotificationStatus();
        
        // Reseting all
        textBasedPreferences.forEach { (arg0) in
            let (values, _) = arg0
            values.options.forEach { (option) in
                option.selected = false
            }
        }
        
        // Date Format
        let selectedDateFormat = UserDefaultsManager.getDateFormat()
        for item in textBasedPreferences[0].values.options {
            if item.title == selectedDateFormat {
                item.selected = true
                textBasedPreferences[0].values.selectedOption = item
                break
            }
        }
        
        // Time Format
        let selectedTimeFormat = UserDefaultsManager.getTimeFormat()
        for item in textBasedPreferences[1].values.options {
            if item.title == selectedTimeFormat {
                item.selected = true
                textBasedPreferences[1].values.selectedOption = item
                break
            }
        }
        
        // Fiat currency
        let fiatCurrencyFormat = UserDefaultsManager.getFiatCurrency()
        for item in textBasedPreferences[2].values.options {
            if item.title == fiatCurrencyFormat {
                item.selected = true
                textBasedPreferences[2].values.selectedOption = item
                break
            }
        }
        
        if !firstViewLoad {
            preferencesCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewLoad = false

        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.AppColors.appBackground
        
        view.addSubview(viewTitle)
        view.addSubview(preferencesCollectionView)
        
        preferencesCollectionView.register(PreferenceTextBasedCollectionViewCell.self, forCellWithReuseIdentifier: PreferenceTextBasedCollectionViewCell.identifier)
        preferencesCollectionView.register(PreferenceSwitchBasedCollectionViewCell.self, forCellWithReuseIdentifier: PreferenceSwitchBasedCollectionViewCell.identifier)
        
        setupTitleLabel()
        setupPreferencesCollectionView()
    }
    
    private func setupTitleLabel(){
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupPreferencesCollectionView(){
        preferencesCollectionView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 49).isActive = true
        preferencesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        preferencesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        preferencesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }

}

//MARK: - CollectionView Section
extension PreferencesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textBasedPreferences.count + switchBasedPreferences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell: UICollectionViewCell? = nil
        
        // TODO: Needs better solution!
        
        if indexPath.row < switchBasedPreferences.count{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceSwitchBasedCollectionViewCell.identifier, for: indexPath) as? PreferenceSwitchBasedCollectionViewCell else{
                fatalError("[CollectionView] - could't deque cell")
            }
            
            if cell.delegate == nil {
                cell.delegate = self
            }
            
            // TODO: Needs unwraping and check
            let index: Int = indexPath.row
            let selection = switchBasedPreferences[index]
            
            cell.updateFieldWithData(preference: selection.value)
            
            returnCell = cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceTextBasedCollectionViewCell.identifier, for: indexPath) as? PreferenceTextBasedCollectionViewCell else{
                fatalError("[CollectionView] - could't deque cell")
            }
            
            // TODO: Needs unwraping and check
            let index: Int = indexPath.row - switchBasedPreferences.count
            let selection = textBasedPreferences[index]
            
            cell.updateFieldWithData(preference: selection.values)
            
            returnCell = cell
        }

        
        return returnCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Selected Switch Based Cell
        if indexPath.row >= switchBasedPreferences.count{
            // Selected Text Based Cell
            let index: Int = indexPath.row - switchBasedPreferences.count
            let selection = textBasedPreferences[index]
            
            // TODO: Fix this with more elegant way. perhaps DB. Right now very hard cupling
            // vc.superViewClosure
            
            let vc = PreferenceSelectionViewController()
            vc.viewData = selection.values
            vc.superViewClosure = selection.updateClosure
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PreferencesViewController: PreferenceSwitchBasedCollectionViewCellDelegate{
    func switchToggleChangedState(_ collectionViewCell: UICollectionViewCell, switchToggle: UISwitch) {
        let indexPath: IndexPath = preferencesCollectionView.indexPath(for: collectionViewCell)!
        if indexPath.row < switchBasedPreferences.count {
            let index: Int = indexPath.row
            
            let selection = switchBasedPreferences[index]
            selection.value.onStatus = switchToggle.isOn
            selection.closure(switchToggle.isOn)
        }
        
        preferencesCollectionView.reloadData()
    }
    
    
}
