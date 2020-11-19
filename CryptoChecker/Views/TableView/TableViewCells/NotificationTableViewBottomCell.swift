//
//  NotificationTableViewBottomCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 19/11/2020.
//

import UIKit

class NotificationTableViewBottomCell: NotificationTableViewCell {
    
    override class var identifier: String{
        return "NotificationTableViewBottomCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = Constants.NotificationController.Cell.Size.cornerRadius
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
