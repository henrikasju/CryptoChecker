//
//  NotificationTableViewHeaderView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 19/11/2020.
//

import UIKit

class NotificationTableViewHeaderView: UITableViewHeaderFooterView {
    
    public static let identifier :String = "NotificationTableViewHeaderView"
    let topViewHeight: CGFloat = 40
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ethereum"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.NotificationController.Cell.Font.title
        return label
    }()
    
    let topSpacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.CurrencyCollection.Cell.Color.background
        view.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(Constants.NotificationController.Cell.Color.above, for: .normal)
        button.titleLabel?.font = Constants.NotificationController.Cell.Font.addButton
        return button
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .none

        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(topSpacer)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            // Spacer
            topSpacer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            topSpacer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            topSpacer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            topSpacer.heightAnchor.constraint(equalToConstant: topViewHeight),
            
            // Label
            currencyLabel.topAnchor.constraint(equalTo: topSpacer.topAnchor, constant: 10),
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Button
            addButton.centerYAnchor.constraint(equalTo: topSpacer.centerYAnchor, constant: 3),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    public func updateFieldWithData(data: Cryptocurrency)
    {
        // currency Label
        let currencyNameImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            let image: UIImage = data.image
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = -5
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 25, height: 25)
            
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencyNameLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: (data.name + " ") )
        currencyNameLabelAttributedString.append(currencyNameImageAttachmentString)
        currencyLabel.attributedText = currencyNameLabelAttributedString
    }
    
    @objc func addButtonPressed(sender: UIButton){
        print("Add button pressed - Cell")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
