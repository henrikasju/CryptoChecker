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
    
    let currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currencyTextSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SYMBOL"
        label.textColor = Constants.CurrencyCollection.Cell.Color.currencySymbol
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencySymbol
        return label
    }()
    
    let currencyValueChangeDirectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let currencyValueChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.00%"
        label.font = Constants.CurrencyCollection.Cell.Fonts.currencyValueChange
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

        
        configureContents()
        
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.notAddedWatchlist, for: .normal)
        currencyWatchlistButton.setBackgroundImage(Constants.CurrencyCollection.Cell.Images.addedWatchlist, for: .selected)
        
        self.bringSubviewToFront(currencyWatchlistButton)
        currencyWatchlistButton.addTarget(self, action: #selector(self.watchlistButtonPressed), for: .touchUpInside)

    }
    
    public func updateFieldWithData(data: Cryptocurrency, representAsFiat: Bool)
    {
        var valueChangeColor: UIColor
        var valueChangedImage: UIImage
        if data.change >= 0 {
            valueChangeColor = Constants.CurrencyCollection.Cell.Color.valueChangeAbove
            valueChangedImage = Constants.NotificationController.Cell.Image.above
        }else{
            valueChangeColor = Constants.CurrencyCollection.Cell.Color.valueChangeBelow
            valueChangedImage = Constants.NotificationController.Cell.Image.below
        }

        // Name Label
        currencyNameLabel.text = data.name
        currencyImageView.image = data.image
        
        // Symbol name Label
        
        // value direction image
        currencyValueChangeDirectionImageView.image = valueChangedImage
        currencyValueChangeDirectionImageView.tintColor = valueChangeColor
        
        currencyValueChangeLabel.textColor = valueChangeColor
        currencyValueChangeLabel.text = data.getChangeAsString() + "%"

//
        currencyTextSymbolLabel.text = data.symbolName
        
        // Currency Value
        let symbol: String = (representAsFiat ? "$" : "₿")
        currencyValueLabel.text = (representAsFiat ? data.getFiatValueAsString() : data.getBitcoinValueAsString()) + symbol
        
        // Watchlist button status
        currencyWatchlistButton.isSelected = data.watchlisted
    }
        
    override func layoutSubviews() {
          super.layoutSubviews()
        
    }
    
    @objc private func watchlistButtonPressed(sender: UIButton){
        if let currentDelegate = self.delegate {
            currentDelegate.watchlistButtonPressed(self, button: sender)
        }
    }
    
    private func configureContents(){
        addSubview(currencyNameLabel)
        addSubview(currencyImageView)
        addSubview(currencyTextSymbolLabel)
        addSubview(currencyValueChangeLabel)
        addSubview(currencyValueChangeDirectionImageView)
        addSubview(currencyValueLabel)
        addSubview(currencyWatchlistButton)
        
        let sidePadding:CGFloat = 15
        let heightPadding: CGFloat = 8
        
        // currency name constraints
        addConstraints([
            // top
            NSLayoutConstraint(item: currencyNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: heightPadding),
            // leading
            NSLayoutConstraint(item: currencyNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: sidePadding),
            // bottom
            NSLayoutConstraint(item: currencyNameLabel, attribute: .bottom, relatedBy: .equal, toItem: currencyTextSymbolLabel, attribute: .top, multiplier: 1, constant: 0),
            
            //height
            NSLayoutConstraint(item: currencyNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (contentView.frame.height - (2 * heightPadding)) / 2)
        ])
        
        NSLayoutConstraint.activate([
            currencyImageView.leadingAnchor.constraint(equalTo: currencyNameLabel.trailingAnchor, constant: 4),
            currencyImageView.centerYAnchor.constraint(equalTo: currencyNameLabel.centerYAnchor, constant: -1),
            currencyImageView.heightAnchor.constraint(equalToConstant: 22),
            currencyImageView.widthAnchor.constraint(equalTo: currencyImageView.heightAnchor, constant: 0),
        ])
        
        // currency symbol constraints
        addConstraints([
            // top
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .top, relatedBy: .equal, toItem: currencyNameLabel, attribute: .bottom, multiplier: 1, constant: 0),
            // leading
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: sidePadding),

            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -heightPadding),
            
            //height
            NSLayoutConstraint(item: currencyTextSymbolLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (contentView.frame.height - (2 * heightPadding)) / 2)
            ])
        
        NSLayoutConstraint.activate([
            // currency change direction image
            
            currencyValueChangeDirectionImageView.leadingAnchor.constraint(equalTo: currencyTextSymbolLabel.trailingAnchor, constant: 4),
            currencyValueChangeDirectionImageView.bottomAnchor.constraint(equalTo: currencyTextSymbolLabel.bottomAnchor, constant: -4),
            currencyValueChangeDirectionImageView.heightAnchor.constraint(equalToConstant: 12),
            currencyValueChangeDirectionImageView.widthAnchor.constraint(equalTo: currencyValueChangeDirectionImageView.heightAnchor, constant: 0),
            
            // Value change label
            currencyValueChangeLabel.centerYAnchor.constraint(equalTo: currencyValueChangeDirectionImageView.centerYAnchor, constant: 0),
            currencyValueChangeLabel.leadingAnchor.constraint(equalTo: currencyValueChangeDirectionImageView.trailingAnchor, constant: 2)
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
