//
//  CSImageView.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/20/23.
//

import UIKit

class CSImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
