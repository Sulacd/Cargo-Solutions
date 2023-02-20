//
//  TrailerCell.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/18/23.
//

import UIKit

class TrailerCell: UITableViewCell {
    
    static let reuseID = "TrailerCell"
    
    let trailerNameLabel = CSTitleLabel(textAlignment: .left, fontSize: 18)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(trailerNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            trailerNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trailerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            trailerNameLabel.heightAnchor.constraint(equalToConstant: 40),
            trailerNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
}
