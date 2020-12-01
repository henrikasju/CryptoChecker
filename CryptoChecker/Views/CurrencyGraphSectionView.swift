//
//  CurrencyGraphSectionView.swift
//  CryptoChecker
//
//  Created by Henrikas J on 30/11/2020.
//

import UIKit

enum TimelineSelection: Int {
    case Day = 1
    case Week = 7
    case Month = 30
    case ThreeMonths = 90
    case Year = 365
    case All = -1
}

class CurrencyGraphSectionView: UIView {
    
    let currentPriceDescriptorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Price"
        label.textColor = Constants.CurrencyDetail.GraphSection.Color.currentPriceDescriptor
        label.font = Constants.CurrencyDetail.GraphSection.Font.currentPriceDescriptor
        
        return label
    }()
    
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00.00 USD"
        label.font = Constants.CurrencyDetail.GraphSection.Font.currentPrice
        label.textAlignment = .center
        
        return label
    }()
    
    let graphImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "graphStub")
        imageView.layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let timelineSelectionButtons: [GraphTimelineSelectionButton] = {
        let buttons = [
            GraphTimelineSelectionButton(title: "24h", timeline: .Day, buttonHeight: 24, buttonWidth: 44, isSelected: true),
            GraphTimelineSelectionButton(title: "7d", timeline: .Week, buttonHeight: 24, buttonWidth: 44, isSelected: false),
            GraphTimelineSelectionButton(title: "30d", timeline: .Month, buttonHeight: 24, buttonWidth: 44, isSelected: false),
            GraphTimelineSelectionButton(title: "90d", timeline: .ThreeMonths, buttonHeight: 24, buttonWidth: 44, isSelected: false),
            GraphTimelineSelectionButton(title: "1y", timeline: .Year, buttonHeight: 24, buttonWidth: 44, isSelected: false),
            GraphTimelineSelectionButton(title: "All", timeline: .All, buttonHeight: 24, buttonWidth: 44, isSelected: false),
        ]
        
        return buttons
    }()
    
    let timelineSelectinoHStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        
        return hStack
    }()
    
    var selectedButton: GraphTimelineSelectionButton

    init() {
        guard let firstButton = timelineSelectionButtons.first else{
            fatalError("Error accessing button in SelectionButtonArray!")
        }
        selectedButton = firstButton
        
        super.init(frame: .zero)
        
        self.backgroundColor = Constants.AppColors.ViewBackground.cell
        self.layer.cornerRadius = Constants.CurrencyCollection.Cell.ViewSizes.cellCornerRadius
        
        
        setupTimelineHStackView()
        configureContents()
    }
    
    public func setupViewWithData(currentPrice: String){
        currentPriceLabel.text = currentPrice
    }
    
    func setupTimelineHStackView() {
        for button in timelineSelectionButtons {
            button.addTarget(self, action: #selector(timelineButtonPressed(sender:)), for: .touchUpInside)
            timelineSelectinoHStackView.addArrangedSubview(button)
        }
    }
    
    func configureContents() {
        self.addSubview(currentPriceDescriptorLabel)
        self.addSubview(currentPriceLabel)
        self.addSubview(graphImageView)
        self.addSubview(timelineSelectinoHStackView)
        
        NSLayoutConstraint.activate([
            currentPriceDescriptorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            currentPriceDescriptorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentPriceDescriptorLabel.heightAnchor.constraint(equalToConstant: 21),
            
            currentPriceLabel.topAnchor.constraint(equalTo: currentPriceDescriptorLabel.bottomAnchor, constant: 0),
            currentPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            currentPriceLabel.heightAnchor.constraint(equalToConstant: 26),
            
            graphImageView.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 12),
            graphImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            graphImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            graphImageView.bottomAnchor.constraint(equalTo: timelineSelectinoHStackView.topAnchor, constant: -8),
            
            timelineSelectinoHStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            timelineSelectinoHStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            timelineSelectinoHStackView.heightAnchor.constraint(equalToConstant: 24),
            timelineSelectinoHStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func timelineButtonPressed(sender: GraphTimelineSelectionButton)
    {
        sender.setButtonSelectionStatus(isSelected: true)
        
        selectedButton.setButtonSelectionStatus(isSelected: false)
        selectedButton = sender
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
