//
//  CurrencyDetailCollectionViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 01/12/2020.
//

import UIKit

class CurrencyDetailCollectionViewCell: UICollectionViewCell {
    
    public static let identifier: String = "CurrencyDetailCollectionViewCell"
    
    let DetailTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Title"
        label.font = Constants.CurrencyDetail.DetailSection.Font.detailTitle
        
        return label
    }()
    
    let DetailValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "00.00"
        label.font = Constants.CurrencyDetail.DetailSection.Font.detailValue
        
        return label
    }()
    
    let bottomSeperatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.CurrencyDetail.DetailSection.Color.cellBottomSeperator
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .none
        configureContents()
    }
    
    public func updateFieldWithData(title: String, detail: String? = nil, atributedDetail: NSAttributedString? = nil){
        DetailTitleLabel.text = title
        
        if detail != nil {
            DetailValueLabel.text = detail
        }else if atributedDetail != nil{
            DetailValueLabel.attributedText = atributedDetail
        }
    }
    
    private func configureContents(){
        let hStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillProportionally
                        
            stack.addArrangedSubview(DetailTitleLabel)
            stack.addArrangedSubview(DetailValueLabel)
                        
            return stack
        }()
        
        self.addSubview(hStack)
        self.addSubview(bottomSeperatorLineView)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            hStack.bottomAnchor.constraint(equalTo: bottomSeperatorLineView.topAnchor, constant: 0),
            
            bottomSeperatorLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bottomSeperatorLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bottomSeperatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
