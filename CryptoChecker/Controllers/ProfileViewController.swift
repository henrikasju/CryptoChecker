//
//  ProfileViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Notification Switch vibrates when selected, do same vibration for text based option selection

class ProfileViewController: UIViewController {

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
    
    let switchBasedPreferences: [PreferenceSwitchBased] = [
        PreferenceSwitchBased(title: "Notifications", onStatus: true)
    ]
    
    let textBasedPreferences: [PreferenceTextBased] = [
        PreferenceTextBased(title: "Data Format", detail: "YYYY-MM-DD"),
        PreferenceTextBased(title: "Time Format", detail: "24 Hours"),
        PreferenceTextBased(title: "Fiat Currency", detail: "USD"),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        preferencesCollectionView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 16).isActive = true
        preferencesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        preferencesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        preferencesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textBasedPreferences.count + switchBasedPreferences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell: UICollectionViewCell? = nil
        
        // TODO: Needs better solution!
        
        if indexPath.row < switchBasedPreferences.count{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceSwitchBasedCollectionViewCell.identifier, for: indexPath) as? PreferenceSwitchBasedCollectionViewCell else{
                fatalError("[CollectionView] - could't deque cell")
            }
            
            // TODO: Needs unwraping and check
            cell.updateFieldWithData(preference: switchBasedPreferences[indexPath.row])
            
            returnCell = cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceTextBasedCollectionViewCell.identifier, for: indexPath) as? PreferenceTextBasedCollectionViewCell else{
                fatalError("[CollectionView] - could't deque cell")
            }
            
            // TODO: Needs unwraping and check
            cell.updateFieldWithData(preference: textBasedPreferences[(indexPath.row - switchBasedPreferences.count)])
            
            returnCell = cell
        }

//        if cell.delegate == nil {
//            cell.delegate = self
//        }

        
        return returnCell!
    }
    
    
}
