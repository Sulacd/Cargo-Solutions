//
//  Document.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 3/1/23.
//

import UIKit

import UIKit

struct Document: Hashable {
    var image: UIImage
    let identifier = UUID()
    
    init(image: UIImage) {
        self.image = image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

