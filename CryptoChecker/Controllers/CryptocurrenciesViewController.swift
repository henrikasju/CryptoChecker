//
//  ViewController.swift
//  CryptoChecker
//
//  Created by Henrikas J on 14/11/2020.
//

import UIKit

class CryptocurrenciesViewController: UIViewController {
    
    lazy var currencyCollectionView: CryptocurrenciesUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = CryptocurrenciesUICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.AppColors.background
        
        currencyCollectionView.register(CryptocurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CryptocurrencyCollectionViewCell.identifier)
        view.addSubview(currencyCollectionView)
        
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        currencyCollectionView.backgroundColor = .none
        currencyCollectionView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            currencyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }


}


//MARK: - CollectionView Section
extension CryptocurrenciesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptocurrencyCollectionViewCell.identifier, for: indexPath)
        
        
        return cell
    }
    

    
    
    
    
}

