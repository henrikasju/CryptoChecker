//
//  PreferencesCollectionViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class PreferenceTextBasedCollectionViewCell: UICollectionViewCell {
    
    public static let identifier :String = "PreferenceTextBasedCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyName
        return label
    }()
    
    let openIcon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Constants.AppColors.ViewBackground.selectedOption
        return image
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detail"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencySymbol
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencySymbol
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.CurrencyCollection.Cell.Color.background
        layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        addSubview(titleLabel)
        addSubview(openIcon)
        addSubview(detailLabel)
        
        setupLabels()
    }
    
    public func updateFieldWithData(preference: PreferenceTextBased){
        titleLabel.text = preference.title
        detailLabel.text = preference.selectedOption?.title
    }
    
    private func setupLabels(){
        let sidePadding: CGFloat = 20
        
        titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sidePadding).isActive = true
        
        detailLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: openIcon.leadingAnchor, constant: -10).isActive = true
        
        openIcon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding).isActive = true
        openIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        openIcon.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        openIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
