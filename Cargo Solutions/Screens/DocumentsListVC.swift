//
//  DocumentsListVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/19/23.
//

import UIKit
import VisionKit

class DocumentsListVC: UIViewController {
    
    var collectionView: UICollectionView!
    var numOfDocuments = 0 
    var documents: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(configureDocumentView))
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
    }

    @objc private func configureDocumentView() {
        documents.removeAll()
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate = self
        self.present(scanningDocumentVC, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubViews(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260)
        ])
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCompositionalLayout())
        collectionView.isScrollEnabled = false
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DocumentCell.self, forCellWithReuseIdentifier: DocumentCell.reuseID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DocumentsListVC: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        numOfDocuments = scan.pageCount
        for pageNum in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNum)
            documents.append(image)
        }
        collectionView.reloadData()
        controller.dismiss(animated: true)
    }
}

extension DocumentsListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return numOfDocuments
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentCell.reuseID, for: indexPath) as! DocumentCell
        cell.documentImageView.image = documents[indexPath.row]
        //cell.documentImageView.image = UIImage(named: "Yordles in Arms")
        return cell
    }
}
