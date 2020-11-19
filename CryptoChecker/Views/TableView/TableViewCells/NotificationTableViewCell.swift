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
        label.text = "Title"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creation date YYYY-MM-DD"
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

        
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Date
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Switch
            statusSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            statusSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    public func updateFieldWithData(data: Cryptocurrency.CurrencyNotification, lastCell: Bool)
    {
        self.lastCell = lastCell
        print(data.date)
    }

    @objc func notificationStatusChanged(sender: UISwitch){
        print("Notification status changed - cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
