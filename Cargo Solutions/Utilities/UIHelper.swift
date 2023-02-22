//
//  UIHelper.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/20/23.
//

import UIKit

enum UIHelper {
    
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.8)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        //section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        //section.supplementariesFollowContentInsets = false
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        config.interSectionSpacing = 18
        
        
        
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        
        return layout
    }
}
