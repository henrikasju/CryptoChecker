//
//  AddNotificationViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 20/11/2020.
//

import UIKit

protocol AddNotificationViewControllerDelegate {
    func AddNotificationPopUpViewWillDisapear(_ viewController: AddNotificationViewController, animated: Bool)
}

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
    
    let currencyDisplaySelectionView: CurrencyDisplaySelectionView = {
        let view = CurrencyDisplaySelectionView(buttonsHeight: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionHeight,
                                                buttonsWidth: Constants.CryptoCurrenciesController.ViewSizes.currencySelectionWidth,
                                                spacing: 16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        textField.text = "00.00"
        textField.font = Constants.NotificationController.Cell.Font.notificationTextField
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        
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

        currencyDisplaySelectionView.fiatButton.setTitle(UserDefaultsManager.getFiatCurrency(), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.AddNotificationPopUpViewWillDisapear(self, animated: animated)
    }
    
    public var data: Cryptocurrency?
    private var representDataToFiat: Bool = true
    public var delegate: AddNotificationViewControllerDelegate?

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
        navigationBarTitleLabel.text = viewData.name
        navigationBarTitleImage.image = viewData.image
        
        updateViewData(viewData: viewData)
    }
    
    private func updateViewData(viewData: Cryptocurrency){
//        let currentCurrencySymbol = String((representDataToFiat ? " $" : " ₿"))
        let preferencesManager = PreferencesManager()
        // TODO: Remove crypto hard code
        let currentCurrencySymbol = representDataToFiat ? " " + preferencesManager.getFiatSymbol() : " ₿"
        let currentPrice: String = representDataToFiat ? preferencesManager.getValueAsSelectedFiatString(value: viewData.valueFiat ) : preferencesManager.getValueAsSelectedFiatString(value: viewData.value)
        
        let currentPriceSecondaryText: NSAttributedString = {
            let textAtributes = [NSAttributedString.Key.foregroundColor: Constants.NotificationController.Cell.Color.secondaryCurrentPrice]
            
            let attributedString: NSAttributedString = NSAttributedString(string: ( "Current Price" ), attributes: textAtributes)
            
            return attributedString
        }()
        
        let currentPriceLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: currentPriceSecondaryText)
        
        currentPriceLabelAttributedString.append(NSMutableAttributedString(string: (" " + currentPrice + " " + currentCurrencySymbol) ))
        
        currentPriceLabel.attributedText = currentPriceLabelAttributedString
        
        let selectedValueText = selectedPriceTextField.text ?? "00.00"
        
        updateNotificationExplanationLabel(currentValue: selectedValueText, symbolName: viewData.symbolName)
    }
    
    private func updateNotificationExplanationLabel(currentValue: String, symbolName: String){
//        let currentCurrencySymbol = String((representDataToFiat ? " $" : " ₿"))
        let preferencesManager = PreferencesManager()
        // TODO: Remove crypto hard code
        let currentCurrencySymbol = representDataToFiat ? " " + preferencesManager.getFiatSymbol() : " ₿"
        let text = "Add notification when\n" + symbolName + " price is " + currentValue + currentCurrencySymbol
        creatingNotificationExplanationLabel.text = text
        
        if (selectedPriceHelperLabel.text?.count ?? 0) > 0 && selectedPriceHelperLabel.textColor == .red {
            selectedPriceHelperLabel.textColor = Constants.NotificationController.Cell.Color.selectedPriceHelperLabel
        }
    }
    
    private func configureMainViewContents(){
        titleHStackView.addArrangedSubview(navigationBarTitleLabel)
        titleHStackView.addArrangedSubview(navigationBarTitleImage)
        
        navigationBar.topItem?.titleView = titleHStackView
        
        view.addSubview(navigationBar)
        view.addSubview(currencyDisplaySelectionView)
        view.addSubview(notificationCreationView)
        view.addSubview(addNotificationButton)
        
        currencyDisplaySelectionView.setTargetToButtons(target: self, action: #selector(currencyConversionButtonPressed(sender:)), event: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            currencyDisplaySelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currencyDisplaySelectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
                        
            notificationCreationView.topAnchor.constraint(equalTo: currencyDisplaySelectionView.bottomAnchor, constant: 16),
            notificationCreationView.leadingAnchor.constraint(equalTo: currencyDisplaySelectionView.leadingAnchor, constant: 0),
            notificationCreationView.trailingAnchor.constraint(equalTo: addNotificationButton.trailingAnchor, constant: 0),
            notificationCreationView.bottomAnchor.constraint(equalTo: addNotificationButton.topAnchor, constant: -16),
            
            addNotificationButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            addNotificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addNotificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

        ])
    }
    
    private func configureNotificationCreationViewContents(){
        notificationCreationView.addSubview(currentPriceLabel)
        notificationCreationView.addSubview(selectedPriceTextField)
        notificationCreationView.addSubview(selectedPriceHelperLabel)
        notificationCreationView.addSubview(creatingNotificationExplanationLabel)
        
        selectedPriceTextField.delegate = self
        
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
            transitioningDelegate.transitionDirection = .toBottom
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func addNotificationButtonPressed(sender: UIButton){
        
        let preferenceManager = PreferencesManager()
        let notificationCurrencyType = (representDataToFiat ? preferenceManager.getFiatName() : "BTC")
        let selectedCurrentPrice = (representDataToFiat ? data?.valueFiat : data?.value)

        if let notificationSetValueText = selectedPriceTextField.text, let currentPrice = selectedCurrentPrice {
            // Modify textfield String Text
            
            if let setValue = getDoubleFromStringWithLocale(valueText: notificationSetValueText) {
                
                if setValue > 0 {
                    let isAboveCurrent = setValue > currentPrice
                    
                    let date = Date()
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd"
                    
                    let creationDate = dateFormat.string(from: date)
                    
                    let notification = Cryptocurrency.CurrencyNotification(setValue: setValue, aboveValue: isAboveCurrent, creationDate: creationDate, currencyType: notificationCurrencyType, isOn: true)
                    
                    data?.notifications.append(notification)
                    
                    if let transitioningDelegate = self.transitioningDelegate as? NotificationTransitioningDelegate{
                        
                        transitioningDelegate.transitionDirection = .toBottom
                        dismiss(animated: true) {
                            self.viewDidDisappear(true)
                        }
                        
                    }
                }else{
                    selectedPriceHelperLabel.textColor = .red
                }
            }else if (selectedPriceTextField.text?.count ?? 0) <= 0 {
                selectedPriceHelperLabel.textColor = .red
            }
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
        
        if(sender == currencyDisplaySelectionView.fiatButton || sender == currencyDisplaySelectionView.cryptoButton) {
            guard let availableData = data else {
                fatalError("Error: Accesing currency data in AddNotificationViewController")
            }
            updateViewData(viewData: availableData)
            textFieldDidChangeSelection(selectedPriceTextField)
        }
        
    }

}

//MARK: - TextField Section
extension AddNotificationViewController: UITextFieldDelegate{
    
    func getDoubleFromStringWithLocale(valueText: String) -> Double?{
        let formatter = NumberFormatter()
        formatter.decimalSeparator = Locale.current.decimalSeparator
        return formatter.number(from: valueText)?.doubleValue
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == selectedPriceTextField, let currentText = textField.text {
            if currentText == "00.00"{
                textField.text = ""
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if var currentText = textField.text, textField == selectedPriceTextField {
            
            let insertIndex = currentText.index(currentText.startIndex, offsetBy: range.location)
            currentText.insert(contentsOf: string, at: insertIndex)
            
            if let stringAsDouble = getDoubleFromStringWithLocale(valueText: currentText){
                return true
            }else{
                return false
            }
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if var currentText = textField.text, let availableData = data, textField == selectedPriceTextField {
                        
            if let decimalSeperator = Locale.current.decimalSeparator,
               let floatingPointIndex = currentText.firstIndex(of: Character(decimalSeperator)),
               representDataToFiat {

                let currentStringAfterSeperator = currentText.suffix(from: floatingPointIndex).dropFirst()
                let allowedPrecision = 2
                
                if currentStringAfterSeperator.count > allowedPrecision {
                    let allowedPrecisionEndIndex = currentText.index(floatingPointIndex, offsetBy: allowedPrecision+1)
                    let acceptedString = String(currentText[..<allowedPrecisionEndIndex])
                    textField.text = acceptedString
                    currentText = acceptedString
                }
            }

            updateNotificationExplanationLabel(currentValue: currentText, symbolName: availableData.symbolName)
        }
    }
}
