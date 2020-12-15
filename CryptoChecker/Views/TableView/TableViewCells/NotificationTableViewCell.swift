//
//  NotificationTitleTableViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

protocol NotificationTableViewCellDelegate {
    func notificationStatusChanged(_ tableViewCell: NotificationTableViewCell, uiSwitch: UISwitch)
}

class NotificationTableViewCell: UITableViewCell {

    class var identifier: String{
        return "NotificationTitleTableViewCell"
    }
//    public static let identifier: String = {
//        return identifierName
//    }()
    
    public var delegate: NotificationTableViewCellDelegate?
    
    let valueChangeDirectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        
        contentView.backgroundColor = Constants.AppColors.ViewBackground.cell
//        contentView.backgroundColor = .red
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.black.cgColor
        backgroundColor = .none
        backgroundView = UIView()
        selectionStyle = .none

        configureContents()
    }
    
    private func configureContents(){
        contentView.addSubview(valueChangeDirectionImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(statusSwitch)
        
        statusSwitch.addTarget(self, action: #selector(toggleSwitchChangedValue(sender:)), for: .valueChanged)
//        statusSwitch.transform = CGAffineTransform(scaleX: 50, y: 20)

        
        NSLayoutConstraint.activate([
            // Value Direction Image
            valueChangeDirectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            valueChangeDirectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueChangeDirectionImageView.heightAnchor.constraint(equalToConstant: 18),
            valueChangeDirectionImageView.widthAnchor.constraint(equalTo: valueChangeDirectionImageView.heightAnchor, constant: 0),
            
            // Title
            titleLabel.centerYAnchor.constraint(equalTo: valueChangeDirectionImageView.centerYAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: valueChangeDirectionImageView.trailingAnchor, constant: 3),
            
            // Date
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            
            // Switch
            statusSwitch.topAnchor.constraint(equalTo: valueChangeDirectionImageView.topAnchor, constant: 0),
            statusSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
    
    public func updateFieldWithData(data: Cryptocurrency.CurrencyNotification)
    {
        // TODO: OPTIMIZE!!!!!
        
        var valueChangedColor: UIColor
        var notificationValueDirection: String
        
        if data.aboveValue {
            notificationValueDirection = "Above"
            valueChangedColor = Constants.NotificationController.Cell.Color.above
            valueChangeDirectionImageView.image = Constants.NotificationController.Cell.Image.above
        }else{
            notificationValueDirection = "Below"
            valueChangedColor = Constants.NotificationController.Cell.Color.below
            valueChangeDirectionImageView.image = Constants.NotificationController.Cell.Image.below
        }
        // Value direction image
        valueChangeDirectionImageView.tintColor = valueChangedColor
                        
        // Title Label
        let currencySymbolValueChangeAttachmentString: NSAttributedString = {
            let valueAtribute = [NSAttributedString.Key.foregroundColor: valueChangedColor, NSAttributedString.Key.font: Constants.NotificationController.Cell.Font.notificationTitle]
            
            let attributedString: NSAttributedString = NSAttributedString(string: ( notificationValueDirection ), attributes: valueAtribute)
            
            return attributedString
        }()
        
        let preferenceManager = PreferencesManager()
        let valueAsString = preferenceManager.getFiatValueString(value: data.setValue)
        let currencyType = data.currencyType == "BTC" ? "BTC" : preferenceManager.getFiatName()
        
        let currencySymbolLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(attributedString: currencySymbolValueChangeAttachmentString)
        currencySymbolLabelAttributedString.append(NSMutableAttributedString(string: " " + valueAsString + " " + currencyType ) )
        
        titleLabel.attributedText = currencySymbolLabelAttributedString
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        
        var formatedDate = "None"
        
        if let date = dateFormater.date(from: data.date){
            dateFormater.dateFormat = UserDefaultsManager.getDateFormat().lowercased()
            formatedDate = dateFormater.string(from: date)
        }
        
        dateLabel.text = "Creation date " + formatedDate
        
        statusSwitch.setOn(data.isOn, animated: false)
    }
    
    @objc private func toggleSwitchChangedValue(sender: UISwitch){
        delegate?.notificationStatusChanged(self, uiSwitch: statusSwitch)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
