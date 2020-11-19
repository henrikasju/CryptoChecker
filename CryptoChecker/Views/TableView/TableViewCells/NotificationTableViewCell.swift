//
//  NotificationTitleTableViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    public static let identifier :String = "NotificationTitleTableViewCell"
    var lastCell: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.NotificationController.Cell.Font.notificationTitle
        label.text = "Title"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creation date YYYY-MM-DD"
        label.textColor = Constants.NotificationController.Cell.Color.date
        label.font = Constants.NotificationController.Cell.Font.date
        return label
    }()
    
    let statusSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.setOn(true, animated: false)
        return toggleSwitch
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Constants.AppColors.ViewBackground.cell
        
        configureContents()
    }
    
    private func configureContents(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(statusSwitch)
        
        statusSwitch.addTarget(self, action: #selector(notificationStatusChanged(sender:)), for: .valueChanged)
//        statusSwitch.transform = CGAffineTransform(scaleX: 50, y: 20)

        
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Date
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16+18+5),
            
            // Switch
            statusSwitch.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 2),
            statusSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    public func updateFieldWithData(data: Cryptocurrency.CurrencyNotification, lastCell: Bool)
    {
        
        // TODO: OPTIMIZE!!!!!!
        self.lastCell = lastCell
        
        let valueChangedColor: UIColor = (data.aboveValue ? Constants.NotificationController.Cell.Color.above : Constants.NotificationController.Cell.Color.below)
        let valueChangedImage: UIImage = (data.aboveValue ? Constants.CurrencyCollection.Cell.Images.valueChangeAbove : Constants.CurrencyCollection.Cell.Images.valueChangeBelow)
        
        // Title Label
        let notificationValueDirection: String = ( data.aboveValue ? " Above" : " Below" )
        
        let currencySymbolImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            var image: UIImage = valueChangedImage
            image = image.withTintColor( valueChangedColor )
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = -3
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 18, height: 18)
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencySymbolValueChangeAttachmentString: NSAttributedString = {
            let valueAtribute = [NSAttributedString.Key.foregroundColor: valueChangedColor, NSAttributedString.Key.font: Constants.NotificationController.Cell.Font.notificationTitle, NSAttributedString.Key.baselineOffset : 0] as [NSAttributedString.Key : Any]
            let attributedString: NSAttributedString = NSAttributedString(string: ( notificationValueDirection ), attributes: valueAtribute)
            
            return attributedString
        }()
        
        let currencySymbolLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString()
        currencySymbolLabelAttributedString.append(currencySymbolImageAttachmentString)
        currencySymbolLabelAttributedString.append(currencySymbolValueChangeAttachmentString)
        currencySymbolLabelAttributedString.append(NSMutableAttributedString(string: " " + data.getSetValueAsString() + " " + data.currencyType) )
        
        titleLabel.attributedText = currencySymbolLabelAttributedString
        
        statusSwitch.setOn(data.isOn, animated: false)
    }

    @objc func notificationStatusChanged(sender: UISwitch){
        print("Notification status changed - cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
