//
//  PreferenceSelectionCollectionViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class PreferenceSelectionCollectionViewCell: UICollectionViewCell {
    
    public static let identifier :String = "PreferenceSelectionCollectionViewCell"
    
    // TODO: Do safer unwraping!
    var selectedImageIcon: UIImage? = UIImage(systemName: "checkmark")
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyName
        return label
    }()
    
    let openIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Constants.AppColors.ViewBackground.selectedOption
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.CurrencyCollection.Cell.Color.background
        layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        addSubview(titleLabel)
        addSubview(openIcon)
        
        setupLabels()
    }
    
    public func updateFieldWithData(preferenceOption: PreferenceTextBased.Option){
        titleLabel.text = preferenceOption.title
        preferenceOption.selected ? (openIcon.image = selectedImageIcon) : (openIcon.image = nil)
    }
    
    private func setupLabels(){
        let sidePadding: CGFloat = 20
        
        titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sidePadding).isActive = true
        
        openIcon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding).isActive = true
        openIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        openIcon.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        openIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
