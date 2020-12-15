//
//  Constants.swift
//  CryptoChecker
//
//  Created by Henrikas J on 15/11/2020.
//

import UIKit

struct Constants{
    
    struct UserDefaults {
        static let alreadyLaunched: (key: String, defaultValue: Bool) = ("AlreadyLaunched", false)
        
        static let globalNotificationStatus: (key: String, defaultValue: Bool) = ("GlobalNotificationStatus", true)
        static let dataFormat: (key: String, defaultValue: String) = ("DataFormat", "YYYY-MM-DD")
        static let timeFormat: (key: String, defaultValue: String) = ("TimeFormat", "24 Hours")
        static let fiatCurrency: (key: String, defaultValue: String) = ("FiatCurrency", "USD")
    }
    
    struct AppColors{
        struct Text {
            static let selectedOption: UIColor = .white
            static let notSelectedOption: UIColor = #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1)
            
            static let green: UIColor = #colorLiteral(red: 0, green: 0.8635755181, blue: 0.1613952219, alpha: 1)
        }
        
        struct ViewBackground {
            static let selectedOption: UIColor = #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1)
            static let notSelectedOption: UIColor = .white
            
            static let cell: UIColor = .white
        }
        
        
        static let appBackground: UIColor = UIColor(rgbRed: 243, rgbGreen: 243, rgbBlue: 243, alpha: 1.0)!
    }
    
    struct CurrencyDetail {
        struct Font {
            static let title: UIFont = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
            static let openNotificationButton: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        }
        
        struct Size {
            static let titleImageHeight: CGFloat = 30
        }
        
        struct GraphSection {
            struct Font {
                static let currentPriceDescriptor: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                static let currentPrice: UIFont = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
            }
            
            struct Color{
                static let currentPriceDescriptor: UIColor = #colorLiteral(red: 0.4587863088, green: 0.4588444233, blue: 0.45876652, alpha: 1)
            }
        }
        
        struct DetailSection{
            struct Font {
                static let header: UIFont = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
                static let detailTitle: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
                static let detailValue: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            }
            
            struct Color{
                static let cellBottomSeperator: UIColor = #colorLiteral(red: 0.9727957845, green: 0.9729318023, blue: 0.9727528691, alpha: 1)
            }
        }
    }
    
    struct NotificationController {
        struct Cell {
            struct Font {
                static let title: UIFont = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
                static let addButton: UIFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
                
                static let notificationTitle: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                static let date: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
                
                static let notificationAddButton: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
                static let notificationTextField: UIFont = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.bold)
                static let selectedPriceHelperLabel: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
                static let creatingNotificationExplanationLabel: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                static let currentPriceLabel: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            }
            struct Size {
                static let cornerRadius: CGFloat = 20.0
            }
            
            struct Color {
                static let date: UIColor = #colorLiteral(red: 0.4509437084, green: 0.4510009885, blue: 0.4509241581, alpha: 1)
                static let above: UIColor = #colorLiteral(red: 0, green: 0.7987864017, blue: 0.2793552876, alpha: 1)
                static let below: UIColor = #colorLiteral(red: 1, green: 0, blue: 0.3098409474, alpha: 1)
                
                static let selectedPriceHelperLabel: UIColor = #colorLiteral(red: 0.4587863088, green: 0.4588444233, blue: 0.45876652, alpha: 1)
                static let secondaryCurrentPrice: UIColor = #colorLiteral(red: 0.4587863088, green: 0.4588444233, blue: 0.45876652, alpha: 1)
                static let mainCurrentPrice: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            
            struct Image {
                static let above: UIImage = {
                    let image = #imageLiteral(resourceName: "triangle-up").withRenderingMode(.alwaysTemplate)
                    return image
                }()
                
                static let below: UIImage = {
                    let image = #imageLiteral(resourceName: "triangle-down").withRenderingMode(.alwaysTemplate)
                    return image
                }()
            }
        }
    }
    
    struct CryptoCurrenciesController{
        struct Fonts {
            static let viewTitle: UIFont = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
            
            static let currencySelection: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        }
        
        struct ViewSizes{
            static let currencySelectionHeight: CGFloat = 25
            static let currencySelectionWidth: CGFloat = 50
            static let currencySelectionRoundness: CGFloat = currencySelectionHeight/2
        }
    }
    
    
    struct CurrencyCollection{
        struct Cell{
            struct Color {
                static let background: UIColor = .white
                static let currencyName: UIColor = .black
                static let currencySymbol: UIColor = .gray
                static let currencyValue: UIColor = .black
                
                static let valueChangeAbove: UIColor = #colorLiteral(red: 0, green: 0.8635755181, blue: 0.1613952219, alpha: 1)
                static let valueChangeBelow: UIColor = #colorLiteral(red: 1, green: 0, blue: 0.3098409474, alpha: 1)
                
                static let addToWatchList: UIColor = AppColors.ViewBackground.selectedOption
            }
            
            struct Images{
                static let notAddedWatchlist: UIImage = UIImage(systemName: "star") ?? UIImage()
                static let addedWatchlist: UIImage = UIImage(systemName: "star.fill") ?? UIImage()
                
                static let valueChangeAbove: UIImage = #imageLiteral(resourceName: "triangle-up")
                static let valueChangeBelow: UIImage = #imageLiteral(resourceName: "triangle-down")
            }
            
            struct ViewSizes{
                static let watchListImageWidth: CGFloat = 35.0
                
                static let cellCornerRadius: CGFloat = 20.0
            }
            
            struct Fonts{
                static let currencyValue: UIFont = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
                static let currencyName: UIFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
                static let currencySymbol: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                static let currencyValueChange: UIFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
            }
        }
    }
    
}
