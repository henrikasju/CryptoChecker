//
//  WatchlistViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class WatchlistViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        watchlistedCurrencies = DataBaseManager.shareInstance.fetchWatchlistedCryptocurrencies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.AppColors.appBackground
        
        view.addSubview(viewTitle)
        view.addSubview(fiatButton)
        view.addSubview(bitcoinButton)
        
        setupTitleLabel()
        setupButtons()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
