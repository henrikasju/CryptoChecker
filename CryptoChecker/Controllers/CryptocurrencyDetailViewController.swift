//
//  CryptocurrencyDetailViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 27/11/2020.
//

import UIKit

class CryptocurrencyDetailViewController: UIViewController {
    
    let tabBarCustomButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, constant: 5).isActive = true
        button.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.notAddedWatchlist, for: .normal)
        button.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.addedWatchlist, for: .selected)
        
        return button
    }()
    
    let tabBarRightItem: UIBarButtonItem = {
        let item = UIBarButtonItem()

        return item
    }()
    
    let currencyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Currency"
        label.font = Constants.CurrencyDetail.Font.title
        
        return label
    }()
    
    let currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: Constants.CurrencyDetail.Size.titleImageHeight).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        return imageView
    }()
    
    let currencyDisplaySelectionView: CurrencyDisplaySelectionView = {
        let view = CurrencyDisplaySelectionView(buttonsHeight: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight,
                                                buttonsWidth: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionWidth,
                                                spacing: 16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let currencyGraphSectionView: CurrencyGraphSectionView = {
        let view = CurrencyGraphSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let openNotificationsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Notifications", for: .normal)
        button.titleLabel?.font = Constants.CurrencyDetail.Font.openNotificationButton
        button.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        button.layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        return button
    }()
    
    var data: Cryptocurrency?
    private var representDataToFiat: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.AppColors.appBackground
        
        print(data?.name)
        guard let availableData = data else {
            fatalError("Error in accessing data at CryptocurrencyDetailViewController!")
        }
        
        configureContents()
        setupViewData(currentData: availableData)
    }
    
    func setupViewData(currentData: Cryptocurrency){
        tabBarCustomButtom.isSelected = currentData.watchlisted
        
        currencyTitleLabel.text = currentData.name
        currencyImageView.image = currentData.image
        
        let currentPriceValue = String((representDataToFiat ? currentData.valueFiat : currentData.valueBitcoin))
        let currentCurrencySymbol = String((representDataToFiat ? "$" : "₿"))
        let currentPriceLabel = currentPriceValue + " " + currentCurrencySymbol
        
        currencyGraphSectionView.setupViewWithData(currentPrice: currentPriceLabel)
    }
    
    func configureContents() {
        tabBarRightItem.customView = tabBarCustomButtom
        tabBarCustomButtom.addTarget(self, action: #selector(watchlistButtonPressed(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = tabBarRightItem
        
        openNotificationsButton.addTarget(self, action: #selector(openNotificatonsButtonPressed(sender:)), for: .touchUpInside)
        
        view.addSubview(currencyTitleLabel)
        view.addSubview(currencyImageView)
        view.addSubview(currencyDisplaySelectionView)
        view.addSubview(currencyGraphSectionView)
        view.addSubview(openNotificationsButton)
        
        NSLayoutConstraint.activate([
            
            currencyTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currencyTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            currencyImageView.leadingAnchor.constraint(equalTo: currencyTitleLabel.trailingAnchor, constant: 3),
            currencyImageView.centerYAnchor.constraint(equalTo: currencyTitleLabel.centerYAnchor, constant: 0),
            
            currencyDisplaySelectionView.leadingAnchor.constraint(equalTo: currencyTitleLabel.leadingAnchor, constant: 0),
            currencyDisplaySelectionView.topAnchor.constraint(equalTo: currencyTitleLabel.bottomAnchor, constant: 8),
            currencyDisplaySelectionView.heightAnchor.constraint(equalToConstant: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight),
            
            currencyGraphSectionView.topAnchor.constraint(equalTo: currencyDisplaySelectionView.bottomAnchor, constant: 12),
            currencyGraphSectionView.leadingAnchor.constraint(equalTo: currencyDisplaySelectionView.leadingAnchor),
            currencyGraphSectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            currencyGraphSectionView.heightAnchor.constraint(equalToConstant: 300),
            
            openNotificationsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            openNotificationsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            openNotificationsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            openNotificationsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func watchlistButtonPressed(sender: UIButton){
        guard let availableData = data else{
            fatalError("Error in accessing data at CryptocurrencyDetailViewController_watchlistButtonPressed!")
        }
        if sender.isSelected {
            sender.isSelected = false
            availableData.watchlisted = false
            
        }else{
            sender.isSelected = true
            availableData.watchlisted = true
        }
    }
    
    @objc func openNotificatonsButtonPressed(sender: UIButton){
        print("Open notification Button pressed!")
    }
    

}
