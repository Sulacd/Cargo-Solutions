//
//  CSButton.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/16/23.
//

import UIKit

class CSButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        self.set(color: color, title: title, systemImageName: systemImageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .trailing
        
        configurationUpdateHandler = { button in

            button.transform = button.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            
        }
    }
}
