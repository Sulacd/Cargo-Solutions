//
//  DocumentsListVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/19/23.
//

import UIKit
import VisionKit

class DocumentsListVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(configureDocumentView))
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }

    @objc private func configureDocumentView() {
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate = self
        self.present(scanningDocumentVC, animated: true)
    }
}

extension DocumentsListVC: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNum in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNum)
            print(image)
        }
        controller.dismiss(animated: true)
    }
}
