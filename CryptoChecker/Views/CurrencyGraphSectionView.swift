//
//  CurrencyGraphSectionView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 30/11/2020.
//

import UIKit

class CurrencyGraphSectionView: UIView {
    
    let currentPriceDescriptorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Price"
        label.textColor = Constants.CurrencyDetail.GraphSection.Color.currentPriceDescriptor
        label.font = Constants.CurrencyDetail.GraphSection.Font.currentPriceDescriptor
        
        return label
    }()
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00.00 USD"
        label.font = Constants.CurrencyDetail.GraphSection.Font.currentPrice
        label.textAlignment = .center
        
        return label
    }()

    init() {
        print("MEMEZ")
        
        super.init(frame: .zero)
        
        self.backgroundColor = Constants.AppColors.ViewBackground.cell
        self.layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        configureContents()
    }
    
    public func setupViewWithData(currentPrice: String){
        currentPriceLabel.text = currentPrice
    }
    
    func configureContents() {
        self.addSubview(currentPriceDescriptorLabel)
        self.addSubview(currentPriceLabel)
        
        NSLayoutConstraint.activate([
            currentPriceDescriptorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            currentPriceDescriptorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            currentPriceLabel.topAnchor.constraint(equalTo: currentPriceDescriptorLabel.bottomAnchor, constant: 0),
            currentPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
