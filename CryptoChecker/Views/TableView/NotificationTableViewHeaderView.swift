//
//  NotificationTableViewHeaderView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 19/11/2020.
//

import UIKit

protocol NotificationTableViewHeaderViewDelegate {
    func notificationAddButtonPressed(tableViewHeaderView: NotificationTableViewHeaderView, button: UIButton)
}

class NotificationTableViewHeaderView: UITableViewHeaderFooterView {
    
    public static let identifier :String = "NotificationTableViewHeaderView"
    public var delegate: NotificationTableViewHeaderViewDelegate?
    
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ethereum"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.NotificationController.Cell.Font.title
        return label
    }()
    
    let currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        contentView.backgroundColor = Constants.AppColors.ViewBackground.cell
        
        contentView.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(currencyLabel)
        contentView.addSubview(currencyImageView)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            // Label
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // TODO: Check why can't I set same height as currentLabel
            
            // Image
            currencyImageView.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 4),
            currencyImageView.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor, constant: 0),
//            currencyImageView.topAnchor.constraint(equalTo: currencyLabel.topAnchor, constant: 0),
//            currencyImageView.bottomAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 0),
            currencyImageView.heightAnchor.constraint(equalToConstant: 25),
            currencyImageView.widthAnchor.constraint(equalTo: currencyImageView.heightAnchor, constant: 0),
//            currencyImageView.heightAnchor.constraint(equalTo: currencyLabel.heightAnchor, constant: 0),
            
            // Button
            addButton.topAnchor.constraint(equalTo: currencyLabel.topAnchor, constant: -5),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    public func updateFieldWithData(data: Cryptocurrency)
    {
        currencyImageView.image = data.image
        currencyLabel.text = data.name
    }
    
    @objc func addButtonPressed(sender: UIButton){
        delegate?.notificationAddButtonPressed(tableViewHeaderView: self, button: addButton)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
