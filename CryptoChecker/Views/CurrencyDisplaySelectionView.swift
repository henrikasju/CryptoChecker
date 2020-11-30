//
//  CurrencyDisplaySelectionView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 30/11/2020.
//

import UIKit

class CurrencyDisplaySelectionView: UIView {
    
    // TODO: Remove hardcoded values!
    
    let fiatButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.isSelected = true
        button.layer.cornerRadius = Constants.CryptoCurrenciesController.ViewSizes.currencySelectionRoundness

        return button
    }()
    
    let cryptoButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BTC", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.layer.cornerRadius = Constants.CryptoCurrenciesController.ViewSizes.currencySelectionRoundness
        
        return button
    }()
    
    var buttonHeight: CGFloat
    var buttonWidth: CGFloat
    var spacing: CGFloat
    
    
    init(buttonsHeight: CGFloat, buttonsWidth: CGFloat, spacing: CGFloat) {
        self.buttonHeight = buttonsHeight
        self.buttonWidth = buttonsWidth
        self.spacing = spacing
        
        super.init(frame: .zero)
        configureContents()
    }
    
    
    func configureContents() {
        self.addSubview(fiatButton)
        self.addSubview(cryptoButton)
        
        NSLayoutConstraint.activate([
            
            fiatButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            fiatButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            fiatButton.widthAnchor.constraint(equalToConstant: self.buttonWidth),
            fiatButton.heightAnchor.constraint(equalToConstant: self.buttonHeight),
            
            cryptoButton.topAnchor.constraint(equalTo: fiatButton.topAnchor),
            cryptoButton.widthAnchor.constraint(equalTo: fiatButton.widthAnchor),
            cryptoButton.heightAnchor.constraint(equalTo: fiatButton.heightAnchor),
            cryptoButton.leadingAnchor.constraint(equalTo: fiatButton.trailingAnchor, constant: self.spacing),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
