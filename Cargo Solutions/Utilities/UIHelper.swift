//
//  UIHelper.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/20/23.
//

import UIKit

enum UIHelper {
    
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.8)), subitems: [item])
        
        
        
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
    
    // Function that creates a collection view layout with 3 columns
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        // Layout of each cell with padding around each side
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // Size of each cell
        flowLayout.itemSize = CGSize(width: availableWidth, height: itemWidth + 60 )
        
        return flowLayout
    }
}
