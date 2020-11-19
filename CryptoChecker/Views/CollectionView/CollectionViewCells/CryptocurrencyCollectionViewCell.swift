//
//  CryptocurrencyTableViewCell.swift
//  CryptoChecker
//
//  Created by Henrikas J on 15/11/2020.
//

import UIKit

protocol CryptocurrencyCollectionViewCellDelegate{
    func watchlistButtonPressed(_ collectionViewCell: UICollectionViewCell, button: UIButton)
}

class CryptocurrencyCollectionViewCell: UICollectionViewCell {
    
    public static let identifier :String = "CurrencyCollectionViewCell"
    
    public var delegate: CryptocurrencyCollectionViewCellDelegate?
        
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Currency Name"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencyName
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyName
        return label
    }()
    
    private let currencyTextSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SYMBOL"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencySymbol
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencySymbol
        return label
    }()
    
    private let currencyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "00.00"
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyValue
        return label
    }()
    
    private let currencyWatchlistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Constants.CurrencyCollection.Cell.Color.addToWatchList
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.CurrencyCollection.Cell.Color.background
        layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
                
        addSubview(currencyNameLabel)
        addSubview(currencyTextSymbolLabel)
        addSubview(currencyValueLabel)
        addSubview(currencyWatchlistButton)
        
        
//        testingViews()
        
        setupLayout()
        
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.notAddedWatchlist, for: .normal)
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.addedWatchlist, for: .selected)
        
        self.bringSubviewToFront(currencyWatchlistButton)
        currencyWatchlistButton.addTarget(self, action: #selector(self.watchlistButtonPressed), for: .touchUpInside)

    }
    
    public func updateFieldWithData(data: Cryptocurrency, representAsFiat: Bool)
    {
        let valueChangedColor: UIColor = (data.change >= 0 ? Constants.CurrencyCollection.Cell.Color.valueChangeAbove : Constants.CurrencyCollection.Cell.Color.valueChangeBelow)
        let valueChangedImage: UIImage = (data.change >= 0 ? Constants.CurrencyCollection.Cell.Images.valueChangeAbove : Constants.CurrencyCollection.Cell.Images.valueChangeBelow)
        // Name Label
        let currencyNameImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            let image: UIImage = data.image
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = -3
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height: 20)
            
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencyNameLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: (data.name + " ") )
        currencyNameLabelAttributedString.append(currencyNameImageAttachmentString)
        currencyNameLabel.attributedText = currencyNameLabelAttributedString
        
        // Symbol name Label
        let currencySymbolImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            var image: UIImage = valueChangedImage
            image = image.withTintColor( valueChangedColor )
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = 0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 10, height: 10)
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencySymbolValueChangeAttachmentString: NSAttributedString = {
            let valueAtribute = [NSAttributedString.Key.foregroundColor: valueChangedColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10.0), NSAttributedString.Key.baselineOffset : 1] as [NSAttributedString.Key : Any]
            let attributedString: NSAttributedString = NSAttributedString(string: (" " + data.getChangeAsString() + "%"), attributes: valueAtribute)
            
            return attributedString
        }()
        
        let currencySymbolLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: (data.symbolName + " ") )
        currencySymbolLabelAttributedString.append(currencySymbolImageAttachmentString)
        currencySymbolLabelAttributedString.append(currencySymbolValueChangeAttachmentString)
        
        currencyTextSymbolLabel.attributedText = currencySymbolLabelAttributedString
        
        // Currency Value
        currencyValueLabel.text = (representAsFiat ? data.getFiatValueAsString() : data.getBitcoinValueAsString())
        
        // Watchlist button status
        currencyWatchlistButton.isSelected = data.watchlisted
    }
        
    override func layoutSubviews() {
          super.layoutSubviews()
        
    }
    
    func testingViews(){
        let currencyNameImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            var image: UIImage = UIImage(systemName: "bitcoinsign.circle.fill")!
            image = image.withTintColor(.systemIndigo)
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = -3
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencyNameLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Bitcoin ")
        currencyNameLabelAttributedString.append(currencyNameImageAttachmentString)
        currencyNameLabel.attributedText = currencyNameLabelAttributedString
        
        let currencySymbolImageAttachmentString: NSAttributedString = {
            let imageAttachment = NSTextAttachment()
            var image: UIImage = Constants.CurrencyCollection.Cell.Images.valueChangeAbove
            image = image.withTintColor(Constants.CurrencyCollection.Cell.Color.valueChangeAbove)
            
            imageAttachment.image = image
            
            let imageOffsetY: CGFloat = 0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 10, height: 10)
            return NSAttributedString(attachment: imageAttachment)
        }()
        
        let currencySymbolValueChangeAttachmentString: NSAttributedString = {
            let valueAtribute = [NSAttributedString.Key.foregroundColor: Constants.CurrencyCollection.Cell.Color.valueChangeAbove, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10.0), NSAttributedString.Key.baselineOffset : 1] as [NSAttributedString.Key : Any]
            let attributedString: NSAttributedString = NSAttributedString(string: " 0.7%", attributes: valueAtribute)
            
            return attributedString
        }()
        
        let currencySymbolLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "BTC ")
        currencySymbolLabelAttributedString.append(currencySymbolImageAttachmentString)
        currencySymbolLabelAttributedString.append(currencySymbolValueChangeAttachmentString)
        
        currencyTextSymbolLabel.attributedText = currencySymbolLabelAttributedString
        
        currencyValueLabel.text = "34254.34"
        
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.notAddedWatchlist, for: .normal)
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.addedWatchlist, for: .selected)
//        contentView.isUserInteractionEnabled = false
//        currencyWatchlistButton.backgroundColor = .red

    }
    
    @objc private func watchlistButtonPressed(sender: UIButton){
        if let currentDelegate = self.delegate {
            currentDelegate.watchlistButtonPressed(self, button: sender)
        }
    }
    
    private func setupLayout(){
        let sidePadding:CGFloat = 15
        let heightPadding: CGFloat = 8
        
        // currency name constraints
        addConstraints([
            // top
            NSLayoutConstraint(item: currencyNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: heightPadding),
            // leading
            NSLayoutConstraint(item: currencyNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: sidePadding),
            // trailing
            NSLayoutConstraint(item: currencyNameLabel, attribute: .trailing, relatedBy: .equal, toItem: currencyValueLabel, attribute: .leading, multiplier: 1, constant: 0),
            // bottom
            NSLayoutConstraint(item: currencyNameLabel, attribute: .bottom, relatedBy: .equal, toItem: currencyTextSymbolLabel, attribute: .top, multiplier: 1, constant: 0),
            
            //height
            NSLayoutConstraint(item: currencyNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (contentView.frame.height - (2 * heightPadding)) / 2)
        ])
        
        // currency symbol constraints
        addConstraints([
            // top
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .top, relatedBy: .equal, toItem: currencyNameLabel, attribute: .bottom, multiplier: 1, constant: 0),
            // leading
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: sidePadding),
            // trailing
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .trailing, relatedBy: .equal, toItem: currencyValueLabel, attribute: .leading, multiplier: 1, constant: 0),
            // bottom
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -heightPadding),
            
            //height
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (contentView.frame.height - (2 * heightPadding)) / 2)
            ])
        
        // Value constraints
        addConstraints([
            // trailing
            NSLayoutConstraint(item: currencyValueLabel, attribute: .trailing, relatedBy: .equal, toItem: currencyWatchlistButton, attribute: .leading, multiplier: 1, constant: -12),

            // width
            NSLayoutConstraint(item: currencyValueLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120),
            // vertical center
            NSLayoutConstraint(item: currencyValueLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            
        ])
        
        
        // Watchlist constraints
        addConstraints([
            
            // trailing
            NSLayoutConstraint(item: currencyWatchlistButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -sidePadding),
            // vertical center
            NSLayoutConstraint(item: currencyWatchlistButton, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: -2),

            // width
            NSLayoutConstraint(item: currencyWatchlistButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.CurrencyCollection.Cell.ViewSizes.watchListImageWidth+5),
            // height
            NSLayoutConstraint(item: currencyWatchlistButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Constants.CurrencyCollection.Cell.ViewSizes.watchListImageWidth),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
