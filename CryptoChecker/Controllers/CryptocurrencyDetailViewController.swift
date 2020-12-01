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
    
    let currencyDetailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Constants.AppColors.ViewBackground.cell
        collectionView.layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        return collectionView
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
    private var selectedTimelineButton: GraphTimelineSelectionButton?
    
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
        
        guard let availableData = data else {
            fatalError("Error in accessing data at CryptocurrencyDetailViewController!")
        }
        
        guard let firstTimelineButton = currencyGraphSectionView.timelineSelectionButtons.first else {
            fatalError("Error accessing button in currencyGraphSectionView.timelineSelectionButtons!")
        }
        selectedTimelineButton = firstTimelineButton
        
        configureContents()
        setupViewData(currentData: availableData)
    }
    
    func setupViewData(currentData: Cryptocurrency){
        navigationItem.backButtonTitle = currentData.name
        
        tabBarCustomButtom.isSelected = currentData.watchlisted
        
        currencyTitleLabel.text = currentData.name
        currencyImageView.image = currentData.image
        
        let currentPriceValue = (representDataToFiat ? currentData.getFiatValueAsString() : currentData.getBitcoinValueAsString())
        let currentCurrencySymbol = String((representDataToFiat ? "$" : "₿"))
        let currentPriceLabel = currentPriceValue + " " + currentCurrencySymbol
        
        currencyGraphSectionView.updateViewWithData(currentPrice: currentPriceLabel)
    }
    
    private func updateViewData(currentData: Cryptocurrency) {
        let currentPriceValue = (representDataToFiat ? currentData.getFiatValueAsString() : currentData.getBitcoinValueAsString())
        let currentCurrencySymbol = String((representDataToFiat ? "$" : "₿"))
        let currentPriceLabel = currentPriceValue + " " + currentCurrencySymbol
        
        currencyGraphSectionView.updateViewWithData(currentPrice: currentPriceLabel)
    }
    
    func configureContents() {
        tabBarRightItem.customView = tabBarCustomButtom
        tabBarCustomButtom.addTarget(self, action: #selector(watchlistButtonPressed(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = tabBarRightItem
        
        currencyDisplaySelectionView.setTargetToButtons(target: self, action: #selector(currencyConversionButtonPressed(sender:)), event: .touchUpInside)
        
        for timelineButton in currencyGraphSectionView.timelineSelectionButtons {
            timelineButton.addTarget(self, action: #selector(graphTimelineChanged(sender:)), for: .touchUpInside)
        }
        
        currencyDetailsCollectionView.delegate = self
        currencyDetailsCollectionView.dataSource = self
        currencyDetailsCollectionView.register(CurrencyDetailCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyDetailCollectionViewCell.identifier)
        currencyDetailsCollectionView.register(CurrencyDetailHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrencyDetailHeaderCollectionReusableView.identifier)
        
        openNotificationsButton.addTarget(self, action: #selector(openNotificatonsButtonPressed(sender:)), for: .touchUpInside)
        
        view.addSubview(currencyTitleLabel)
        view.addSubview(currencyImageView)
        view.addSubview(currencyDisplaySelectionView)
        view.addSubview(currencyGraphSectionView)
        view.addSubview(currencyDetailsCollectionView)
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
            currencyGraphSectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/2.6),
            
            currencyDetailsCollectionView.topAnchor.constraint(equalTo: currencyGraphSectionView.bottomAnchor, constant: 12),
            currencyDetailsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currencyDetailsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            currencyDetailsCollectionView.bottomAnchor.constraint(equalTo: openNotificationsButton.topAnchor, constant: -12),
            
            openNotificationsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            openNotificationsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            openNotificationsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            openNotificationsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        currencyDetailsCollectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

//MARK: - DetailsCollectionView Section
extension CryptocurrencyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let availableData = self.data {
            return availableData.detailSections.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let availableSections = self.data?.detailSections[section] {
            return availableSections.details.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetPadding: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right
        let horizontalSpacing: CGFloat = 8
        let finalWidth: CGFloat = ((collectionView.frame.width - insetPadding) / 2) - horizontalSpacing
        let finalHeight: CGFloat = 20
        
        return CGSize(width: finalWidth, height: finalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrencyDetailHeaderCollectionReusableView.identifier, for: indexPath) as? CurrencyDetailHeaderCollectionReusableView, let headerTitle = data?.detailSections[indexPath.section].title else{
                fatalError("Error: invalid supplementary view type!")
            }
            
            headerView.headerTitleLabel.text = headerTitle
            
            return headerView
            
        default:
            fatalError("Error: Inavlid supplementary view kind!")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyDetailCollectionViewCell.identifier, for: indexPath) as? CurrencyDetailCollectionViewCell, let cellDetail = data?.detailSections[indexPath.section].details[indexPath.row] else{
            fatalError("[CollectionView] - Error dequeing cell")
        }
        
        let currentCurrencySymbol = String((representDataToFiat ? " $" : " ₿"))
        
        if let textDetail = cellDetail as? Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail {
            if let stringDetail = textDetail.detailValue {
                cell.updateFieldWithData(title: textDetail.detailTitle, detail: stringDetail, atributedDetail: nil)
            }else if let atributedStringDetail = textDetail.atributedValue {
                cell.updateFieldWithData(title: textDetail.detailTitle, detail: nil, atributedDetail: atributedStringDetail)
            }
        }else if let valueDetail = cellDetail as? Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail {
            if self.representDataToFiat {
                cell.updateFieldWithData(title: valueDetail.detailTitle, detail: valueDetail.getFiatValueAsString()+currentCurrencySymbol, atributedDetail: nil)
            }else{
                cell.updateFieldWithData(title: valueDetail.detailTitle, detail: valueDetail.getCryptoValueAsString()+currentCurrencySymbol, atributedDetail: nil)
            }
        }
        
        
        return cell
    }
}

//MARK: - Button Action Section
extension CryptocurrencyDetailViewController{
    
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
        
        if(sender == currencyDisplaySelectionView.fiatButton || sender == currencyDisplaySelectionView.cryptoButton){
            // UPDATE
            guard let availableData = data else {
                fatalError("Error in accessing data at CryptocurrencyDetailViewController!")
            }
            
            updateViewData(currentData: availableData)
            
            currencyDetailsCollectionView.reloadData()
        }
        
    }
    
    @objc func graphTimelineChanged(sender: GraphTimelineSelectionButton){
        print("Changed Timelime to: ", sender.timelineRepresentation)
        
        if sender == selectedTimelineButton {
            return
        }
        
        sender.setButtonSelectionStatus(isSelected: true)
        
        selectedTimelineButton!.setButtonSelectionStatus(isSelected: false)
        selectedTimelineButton = sender
    }
    
    @objc func openNotificatonsButtonPressed(sender: UIButton){
        print("Open notification Button pressed!")
        guard let availableCurrency = data else {
            fatalError("Error accessing data in CryptocurrencyDetailViewController")
        }
        
        let vc = NotificationsViewController()
        vc.showAllCurrencies = false
        vc.currenciesWithNotifications = [availableCurrency]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
