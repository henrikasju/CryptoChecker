//
//  GraphTimelineSelectionButton.swift
//  CryptoChecker
//
//  Created by Henrikas J on 01/12/2020.
//

import UIKit

class GraphTimelineSelectionButton: UIButton {
    
    let selectedBackgroundColor: UIColor = Constants.AppColors.ViewBackground.selectedOption
    let notSelectedBackgroundColor: UIColor = Constants.AppColors.ViewBackground.notSelectedOption
    let borderColor: UIColor = Constants.AppColors.ViewBackground.selectedOption
    
    var buttonHeight: CGFloat
    var buttonWidth: CGFloat
    var timelineRepresentation: TimelineSelection

    init(title: String, timeline: TimelineSelection, buttonHeight: CGFloat, buttonWidth: CGFloat, isSelected: Bool) {
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.timelineRepresentation = timeline
        
        super.init(frame: .zero)
        
        self.titleLabel?.font = Constants.CryptoCurrenciesController.Fonts.currencySelection
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = buttonHeight/2
        self.layer.borderWidth = 1
        
        self.setTitleColor(selectedBackgroundColor, for: .normal)
        self.setTitleColor(notSelectedBackgroundColor, for: .selected)
        self.layer.borderColor = self.borderColor.cgColor
        
        setButtonSelectionStatus(isSelected: isSelected)
        
        configureContents()
    }
    
    public func setButtonSelectionStatus(isSelected: Bool){
        if isSelected {
            self.isSelected = true
            self.backgroundColor = selectedBackgroundColor
        }else{
            self.isSelected = false
            self.backgroundColor = notSelectedBackgroundColor
        }
    }
    
    func configureContents(){
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: buttonHeight),
            self.widthAnchor.constraint(equalToConstant: buttonWidth),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
