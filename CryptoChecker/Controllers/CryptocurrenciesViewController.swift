//
//  ViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 14/11/2020.
//

import UIKit

class CryptocurrenciesViewController: UIViewController {
    
    lazy var currencyCollectionView: CryptocurrenciesUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = CryptocurrenciesUICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
    
    let viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cryptocurrencies"
        label.font = Constants.CryptoCurrenciesController.Fonts.viewTitle
        return label
    }()
    
    private var representDataToFiat: Bool = true
    private var cryptocurrencies: [Cryptocurrency] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        cryptocurrencies = DataBaseManager.shareInstance.fetchCryptocurrencies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.AppColors.appBackground
        
        currencyCollectionView.register(CryptocurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CryptocurrencyCollectionViewCell.identifier)
        
        view.addSubview(viewTitle)
        view.addSubview(fiatButton)
        view.addSubview(bitcoinButton)
        view.addSubview(currencyCollectionView)
        
        setupTitleLabel()
        setupButtons()
        setupCollectionView()
        
        fiatButton.addTarget(self, action: #selector(currencyConversionButtonPressed(sender: )), for: .touchUpInside)
        bitcoinButton.addTarget(self, action: #selector(currencyConversionButtonPressed(sender: )), for: .touchUpInside)
        
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
        currencyCollectionView.backgroundColor = .none
        currencyCollectionView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            currencyCollectionView.topAnchor.constraint(equalTo: fiatButton.bottomAnchor, constant: 16),
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            currencyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }


}


//MARK: - CollectionView Section
extension CryptocurrenciesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cryptocurrencies.count
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
        
        let cryptocurrency: Cryptocurrency = cryptocurrencies[indexPath.row]
        cell.updateFieldWithData(data: cryptocurrency, representAsFiat: representDataToFiat)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pressing collection view cell")
    }
    
}

//MARK: CryptocurrencyCollectionViewCellDelegate Section
extension CryptocurrenciesViewController: CryptocurrencyCollectionViewCellDelegate{
    func watchlistButtonPressed(_ collectionViewCell: UICollectionViewCell, button: UIButton) {
        // TODO: add/remove to/from watchlist currency
        if button.isSelected {
            button.isSelected = false
        }else{
            button.isSelected = true
        }
        
        // TODO: Unwrap
        let indexPath: IndexPath = currencyCollectionView.indexPath(for: collectionViewCell)!
        let currencySelected: Cryptocurrency = cryptocurrencies[indexPath.row]
        currencySelected.watchlisted = button.isSelected
//        DataBaseManager.shareInstance.updateData(, to: <#T##Cryptocurrency#>)
    }
    
    
}

//MARK: - Button Action Section
extension CryptocurrenciesViewController{
    
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
            currencyCollectionView.reloadData()
        }
        
    }
}

