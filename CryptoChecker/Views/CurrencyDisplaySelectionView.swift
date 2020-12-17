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
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.selectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.isSelected = true
        button.layer.cornerRadius = Constants.CryptoCurrenciesController.ViewSizes.currencySelectionRoundness

        return button
    }()
    
    let cryptoButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("BTC", for: .normal)
        button.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        
        button.backgroundColor = Constants.AppColors.ViewBackground.notSelectedOption
        button.setTitleColor(Constants.AppColors.Text.selectedOption, for: .selected)
        button.setTitleColor(Constants.AppColors.Text.notSelectedOption, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.isSelected = false
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
    
    public func setTargetToButtons(target: Any, action: Selector, event: UIControl.Event){
        fiatButton.addTarget(target, action: action, for: event)
        cryptoButton.addTarget(target, action: action, for: event)
    }
    
    
    func configureContents() {
        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.alignment = .center
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = self.spacing

            stack.addArrangedSubview(fiatButton)
            stack.addArrangedSubview(cryptoButton)

            return stack
        }()
        
        self.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            
            fiatButton.widthAnchor.constraint(equalToConstant: self.buttonWidth),
            fiatButton.heightAnchor.constraint(equalToConstant: self.buttonHeight),

            cryptoButton.widthAnchor.constraint(equalTo: fiatButton.widthAnchor),
            cryptoButton.heightAnchor.constraint(equalTo: fiatButton.heightAnchor),
            
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hStack.topAnchor.constraint(equalTo: self.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
