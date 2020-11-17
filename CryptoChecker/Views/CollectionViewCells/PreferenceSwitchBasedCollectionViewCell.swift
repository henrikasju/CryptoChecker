//
//  PreferenceSwitchBasedCollectionViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class PreferenceSwitchBasedCollectionViewCell: UICollectionViewCell {
    
    public static let identifier :String = "PreferenceSwitchBasedCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyName
        return label
    }()
    
    let switchToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        return toggle;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.CurrencyCollection.Cell.Color.background
        layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        addSubview(titleLabel)
        addSubview(switchToggle)
        
        setupUIComponents()
    }
    
    public func updateFieldWithData(preference: PreferenceSwitchBased){
        titleLabel.text = preference.title
        switchToggle.isOn = preference.onStatus
    }
    
    private func setupUIComponents(){
        let sidePadding: CGFloat = 20
        
        titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sidePadding).isActive = true
        
        switchToggle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding).isActive = true
        switchToggle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        switchToggle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
//        switchToggle.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
