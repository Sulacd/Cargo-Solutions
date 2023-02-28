//
//  CSToolBar.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/27/23.
//

import UIKit
import MessageUI

class CSToolBar: UIToolbar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        barStyle = .default
        isTranslucent = true
        barTintColor = .systemGroupedBackground
        tintColor = .systemBlue
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
}
