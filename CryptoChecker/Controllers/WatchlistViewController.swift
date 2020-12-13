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
    
    let currencyDisplaySelectionView: CurrencyDisplaySelectionView = {
        let view = CurrencyDisplaySelectionView(buttonsHeight: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight,
                                                buttonsWidth: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionWidth,
                                                spacing: 16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var watchlistedCurrencies: [Cryptocurrency] = []
    private var representDataToFiat: Bool = true
    
    var firstViewLoad: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        watchlistedCurrencies = DataBaseManager.shareInstance.fetchWatchlistedCryptocurrencies()
        if !firstViewLoad {
            watchlistCollectionView.reloadData()
        }
        
        currencyDisplaySelectionView.fiatButton.setTitle(UserDefaultsManager.getFiatCurrency(), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewLoad = false
        navigationItem.backButtonTitle = "Watchlist"

        view.backgroundColor = Constants.AppColors.appBackground
        
        watchlistCollectionView.register(CryptocurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CryptocurrencyCollectionViewCell.identifier)
        
        view.addSubview(viewTitle)
        view.addSubview(currencyDisplaySelectionView)
        view.addSubview(watchlistCollectionView)
        
        setupTitleLabel()
        setupButtons()
        setupCollectionView()
        
        currencyDisplaySelectionView.setTargetToButtons(target: self, action: #selector(currencyConversionButtonPressed(sender:)), event: .touchUpInside)
    }
    
    private func setupTitleLabel(){
        viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    private func setupButtons(){
        currencyDisplaySelectionView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
        currencyDisplaySelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupCollectionView(){
        
        NSLayoutConstraint.activate([
            watchlistCollectionView.topAnchor.constraint(equalTo: currencyDisplaySelectionView.bottomAnchor, constant: 16),
            watchlistCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            watchlistCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            watchlistCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

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
        let selectedCurrencyIndex = indexPath.row
        let dataToPass = watchlistedCurrencies[selectedCurrencyIndex]
        let vc = CryptocurrencyDetailViewController()
        vc.data = dataToPass
        vc.hidesBottomBarWhenPushed = true;
        
        self.navigationController?.pushViewController(vc, animated: true)
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
        let index: Int = indexPath.row
        let currencySelected: Cryptocurrency = watchlistedCurrencies[index]
        currencySelected.watchlisted = button.isSelected
        
        watchlistedCurrencies.remove(at: index)
        watchlistCollectionView.reloadData()
//        DataBaseManager.shareInstance.updateData(, to: <#T##Cryptocurrency#>)
    }
    
    
}

//MARK: - Button Action Section
extension WatchlistViewController{
    
    @objc func currencyConversionButtonPressed(sender: UIButton){
        
        if sender == currencyDisplaySelectionView.fiatButton {
            representDataToFiat = true
            currencyDisplaySelectionView.fiatButton.isSelected = true
            currencyDisplaySelectionView.fiatButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
            
            currencyDisplaySelectionView.cryptoButton.isSelected = false
            currencyDisplaySelectionView.cryptoButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption

        }else if sender == currencyDisplaySelectionView.cryptoButton {
            representDataToFiat = false
            currencyDisplaySelectionView.fiatButton.isSelected = false
            currencyDisplaySelectionView.fiatButton.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
            
            currencyDisplaySelectionView.cryptoButton.isSelected = true
            currencyDisplaySelectionView.cryptoButton.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        }
        
        if(sender == currencyDisplaySelectionView.fiatButton || sender == currencyDisplaySelectionView.cryptoButton) {
            // UPDATE
            watchlistCollectionView.reloadData()
        }
        
    }
}
