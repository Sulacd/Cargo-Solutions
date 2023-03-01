//
//  Array+Ext.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/28/23.
//

import UIKit
import PDFKit

extension Array where Element: UIImage {
    
      func makePDF()-> PDFDocument? {
        let pdfDocument = PDFDocument()
        for (index,image) in self.enumerated() {
            let pdfPage = PDFPage(image: image)
            pdfDocument.insert(pdfPage!, at: index)
        }
        return pdfDocument
    }
}
