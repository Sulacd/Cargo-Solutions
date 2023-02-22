//
//  DocumentCell.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/20/23.
//

import UIKit

class DocumentCell: UICollectionViewCell {
    
    static let reuseID = "DocumentCell"
    
    let documentImageView = CSImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func configure() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.masksToBounds = true
        
        layer.masksToBounds = false
        
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        contentView.addSubViews(documentImageView)
        
        NSLayoutConstraint.activate([
            documentImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            documentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            documentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            documentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
