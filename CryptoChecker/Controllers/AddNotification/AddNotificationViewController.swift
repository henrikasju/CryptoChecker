//
//  AddNotificationViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 20/11/2020.
//

import UIKit

class AddNotificationViewController: UIViewController {
    
    // TODO: Should be views should be seperated into seperate view files!
    
    let navigationBarTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Currency"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return titleLabel
    }()
    
    let navigationBarTitleImage: UIImageView = {
        let imageView = UIImageView()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
        
        return imageView
    }()
    
    let titleHStackView: UIStackView = {
        let hStack = UIStackView()
        
        hStack.spacing = 2
        hStack.alignment = .center
        
        return hStack
    }()
    
    var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed(sender:)))
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = leftBarButton
        
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        
        bar.setItems([navigationItem], animated: false)
        
        return bar
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
    
    let notificationCreationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.AppColors.ViewBackground.cell
        view.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        
        return view
    }()
        
    let addNotificationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("Add Notification", for: .normal)
        button.titleLabel?.font = Constants.NotificationController.Cell.Font.notificationAddButton
        button.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        button.addTarget(self, action: #selector(addNotificationButtonPressed(sender:)), for: .touchUpInside)
        button.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        
        return button
    }()
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Price 00.00 X"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Constants.NotificationController.Cell.Font.currentPriceLabel
        
        return label
    }()
    
    let selectedPriceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "00.00 USD"
        textField.font = Constants.NotificationController.Cell.Font.notificationTextField
        textField.textAlignment = .center
        
        return textField
    }()
    
    let selectedPriceHelperLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Set price alert"
        label.font = Constants.NotificationController.Cell.Font.selectedPriceHelperLabel
        label.textColor = Constants.NotificationController.Cell.Color.selectedPriceHelperLabel
        
        return label
    }()
    
    let creatingNotificationExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add notification when\n YYY price is 00.00 USD"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = Constants.NotificationController.Cell.Font.creatingNotificationExplanationLabel
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    public var data: Cryptocurrency?
    private var representDataToFiat: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.AppColors.appBackground

        
        configureMainViewContents()
        configureNotificationCreationViewContents()
        
        guard let existingData = data else{
            fatalError("Could not access data in AddNotificationViewController")
        }
        
        setupViewData(viewData: existingData)
    }
    
    public func setupViewData(viewData: Cryptocurrency){
        let currentPrice = String((representDataToFiat ? viewData.valueFiat : viewData.valueBitcoin))
        let currentCurrencySymbol = String((representDataToFiat ? "$" : "₿"))
        
        navigationBarTitleLabel.text = viewData.name
        navigationBarTitleImage.image = viewData.image
        
        let currentPriceSecondaryText: NSAttributedString = {
            let textAtributes = [NSAttributedString.Key.foregroundColor: Constants.NotificationController.Cell.Color.secondaryCurrentPrice]
            
            let attributedString: NSAttributedString = NSAttributedString(string: ( "Current Price" ), attributes: textAtributes)
            
            return attributedString
        }()
        
        let currentPriceLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: currentPriceSecondaryText)
        
        currentPriceLabelAttributedString.append(NSMutableAttributedString(string: (" " + currentPrice + " " + currentCurrencySymbol) ))
        
        currentPriceLabel.attributedText = currentPriceLabelAttributedString
    }
    
    private func configureMainViewContents(){
        titleHStackView.addArrangedSubview(navigationBarTitleLabel)
        titleHStackView.addArrangedSubview(navigationBarTitleImage)
        
        navigationBar.topItem?.titleView = titleHStackView
        
        view.addSubview(navigationBar)
        view.addSubview(fiatButton)
        view.addSubview(bitcoinButton)
        view.addSubview(notificationCreationView)
        view.addSubview(addNotificationButton)
        
        fiatButton.addTarget(self, action: #selector(currencyConversionButtonPressed(sender:)), for: .touchUpInside)
        bitcoinButton.addTarget(self, action: #selector(currencyConversionButtonPressed(sender:)), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            fiatButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fiatButton.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            
            bitcoinButton.leadingAnchor.constraint(equalTo: fiatButton.trailingAnchor, constant: 16),
            bitcoinButton.topAnchor.constraint(equalTo: fiatButton.topAnchor, constant: 0),
            
            notificationCreationView.topAnchor.constraint(equalTo: fiatButton.bottomAnchor, constant: 16),
            notificationCreationView.leadingAnchor.constraint(equalTo: fiatButton.leadingAnchor, constant: 0),
            notificationCreationView.trailingAnchor.constraint(equalTo: addNotificationButton.trailingAnchor, constant: 0),
            notificationCreationView.bottomAnchor.constraint(equalTo: addNotificationButton.topAnchor, constant: -16),
            
            addNotificationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            addNotificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addNotificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

        ])
    }
    
    private func configureNotificationCreationViewContents(){
        notificationCreationView.addSubview(currentPriceLabel)
        notificationCreationView.addSubview(selectedPriceTextField)
        notificationCreationView.addSubview(selectedPriceHelperLabel)
        notificationCreationView.addSubview(creatingNotificationExplanationLabel)
        
        guard var textFieldYoffset = selectedPriceTextField.font?.pointSize else {
            fatalError("Could not access TextField point size in AddNotificationViewController")
        }
        
        textFieldYoffset /= 2
        
        NSLayoutConstraint.activate([
            currentPriceLabel.topAnchor.constraint(equalTo: notificationCreationView.topAnchor, constant: 8),
            currentPriceLabel.leadingAnchor.constraint(equalTo: notificationCreationView.leadingAnchor, constant: 16),
            currentPriceLabel.trailingAnchor.constraint(equalTo: notificationCreationView.trailingAnchor, constant: -16),
            
            selectedPriceTextField.centerYAnchor.constraint(equalTo: notificationCreationView.centerYAnchor, constant: -textFieldYoffset),
            selectedPriceTextField.leadingAnchor.constraint(equalTo: notificationCreationView.leadingAnchor, constant: 16),
            selectedPriceTextField.trailingAnchor.constraint(equalTo: notificationCreationView.trailingAnchor, constant: -16),
            
            selectedPriceHelperLabel.topAnchor.constraint(equalTo: selectedPriceTextField.bottomAnchor, constant: 0),
            selectedPriceHelperLabel.centerXAnchor.constraint(equalTo: selectedPriceTextField.centerXAnchor),
            
            creatingNotificationExplanationLabel.bottomAnchor.constraint(equalTo: notificationCreationView.bottomAnchor, constant: -8),
            creatingNotificationExplanationLabel.leadingAnchor.constraint(equalTo: notificationCreationView.leadingAnchor, constant: 16),
            creatingNotificationExplanationLabel.trailingAnchor.constraint(equalTo: notificationCreationView.trailingAnchor, constant: -16),
        ])

    }
    
    @objc func cancelButtonPressed(sender: UIButton){

        if let transitioningDelegate = self.transitioningDelegate as? NotificationTransitioningDelegate{
            transitioningDelegate.transitionDirection = .toLeft
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func addNotificationButtonPressed(sender: UIButton){
        
        if let transitioningDelegate = self.transitioningDelegate as? NotificationTransitioningDelegate{
            transitioningDelegate.transitionDirection = .fromTop
            dismiss(animated: true, completion: nil)
        }
    }
    
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
//            watchlistCollectionView.reloadData()
        }
        
    }

}

//MARK: - TextField Section
extension AddNotificationViewController: UITextFieldDelegate{
    
}
