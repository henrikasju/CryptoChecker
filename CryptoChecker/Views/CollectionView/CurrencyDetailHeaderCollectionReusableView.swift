//
//  CurrencyDetailHeaderCollectionReusableView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 01/12/2020.
//

import UIKit

class CurrencyDetailHeaderCollectionReusableView: UICollectionReusableView {
    public static let identifier: String = "CurrencyDetailHeaderCollectionReusableView"
    
    let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.textAlignment = .left
        label.font = Constants.CurrencyDetail.DetailSection.Font.header
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .none
        
        configureContents()
    }
    
    private func configureContents(){
        self.addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            headerTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            headerTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            headerTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
