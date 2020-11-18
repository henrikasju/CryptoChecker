//
//  WatchlistViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    lazy var watchlistCollectionView: CryptocurrenciesUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = CryptocurrenciesUICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watchlist"
        label.font = Constants.CryptoCurrenciesController.Fonts.viewTitle
        return label
    }()
    
    let fiatButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight).isActive = true
        button.widthAnchor.constraint(equalToConstant: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionWidth).isActive = true
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.isSelected = true
        button.layer.cornerRadius = Constants.CryptoCurrenciesController.ViewSizes.currencySelectionRoundness

        return button
    }()
    
    let bitcoinButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight).isActive = true
        button.widthAnchor.constraint(equalToConstant: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionWidth).isActive = true
        button.setTitle("BTC", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.layer.cornerRadius = Constants.CryptoCurrenciesController.ViewSizes.currencySelectionRoundness
        
        return button
    }()
    
    private var watchlistedCurrencies: [Cryptocurrency] = []
    private var representDataToFiat: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        watchlistedCurrencies = DataBaseManager.shareInstance.fetchWatchlistedCryptocurrencies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.AppColors.appBackground
        
        watchlistCollectionView.register(CryptocurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CryptocurrencyCollectionViewCell.identifier)
        
        view.addSubview(viewTitle)
        view.addSubview(fiatButton)
        view.addSubview(bitcoinButton)
        view.addSubview(watchlistCollectionView)
        
        setupTitleLabel()
        setupButtons()
        setupCollectionView()
        
        print(watchlistedCurrencies.count)
    }
    
    private func setupTitleLabel(){
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupButtons(){
        fiatButton.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
        fiatButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        bitcoinButton.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
        bitcoinButton.leadingAnchor.constraint(equalTo: fiatButton.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupCollectionView(){
        
        NSLayoutConstraint.activate([
            watchlistCollectionView.topAnchor.constraint(equalTo: fiatButton.bottomAnchor, constant: 16),
            watchlistCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            watchlistCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            watchlistCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
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

//MARK: - CollectionView Section
extension WatchlistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchlistedCurrencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptocurrencyCollectionViewCell.identifier, for: indexPath) as? CryptocurrencyCollectionViewCell else{
            fatalError("[CollectionView] - could't deque cell")
        }
        
        if cell.delegate == nil {
            cell.delegate = self
        }
        
        let cryptocurrency: Cryptocurrency = watchlistedCurrencies[indexPath.row]
        cell.updateFieldWithData(data: cryptocurrency, representAsFiat: representDataToFiat)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pressing collection view cell")
    }
    
}

//MARK: CryptocurrencyCollectionViewCellDelegate Section
extension WatchlistViewController: CryptocurrencyCollectionViewCellDelegate{
    func watchlistButtonPressed(_ collectionViewCell: UICollectionViewCell, button: UIButton) {
        // TODO: add/remove to/from watchlist currency
        if button.isSelected {
            button.isSelected = false
        }else{
            button.isSelected = true
        }
        
        // TODO: Unwrap
        let indexPath: IndexPath = watchlistCollectionView.indexPath(for: collectionViewCell)!
        let currencySelected: Cryptocurrency = watchlistedCurrencies[indexPath.row]
        currencySelected.watchlisted = button.isSelected
//        DataBaseManager.shareInstance.updateData(, to: <#T##Cryptocurrency#>)
    }
    
    
}

//MARK: - Button Action Section
extension WatchlistViewController{
    
    @objc private func currencyConversionButtonPressed(sender: UIButton){
        if sender == fiatButton {
            print("Fiat Button pressed!")
            
            if fiatButton.isSelected {
                fiatButton.isSelected = false
                fiatButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
                
                bitcoinButton.isSelected = true
                bitcoinButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
                
                representDataToFiat = false
            }else{
                fiatButton.isSelected = true
                fiatButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
                
                bitcoinButton.isSelected = false
                bitcoinButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
                
                representDataToFiat = true
            }
        }else if( sender == bitcoinButton){
            print("BTC Button pressed!")
            
            if bitcoinButton.isSelected {
                bitcoinButton.isSelected = false
                bitcoinButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
                
                fiatButton.isSelected = true
                fiatButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
                
                representDataToFiat = true
            }else{
                bitcoinButton.isSelected = true
                bitcoinButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
                
                fiatButton.isSelected = false
                fiatButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
                
                representDataToFiat = false
            }
        }
        
        if(sender == fiatButton || sender == bitcoinButton){
            // UPDATE
            watchlistCollectionView.reloadData()
        }
        
    }
}
