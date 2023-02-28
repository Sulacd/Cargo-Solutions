//
//  DocumentsListVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/19/23.
//

import UIKit
import VisionKit
import MessageUI

class DocumentsListVC: UIViewController {
    
    var collectionView: UICollectionView!
    var csToolBar: CSToolBar!
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
        configureToolBar()
        configureViewController()
    }

    @objc private func configureDocumentView() {
        documents = []      
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate = self
        self.present(scanningDocumentVC, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubViews(collectionView, csToolBar)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260)
        ])
        
        NSLayoutConstraint.activate([
            csToolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            csToolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            csToolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    private func configureToolBar() {
        csToolBar = CSToolBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sendButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendMail))
        let editButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(sendMail))
        
        csToolBar.setItems([flexibleButton, sendButton, flexibleButton, editButton, flexibleButton], animated: true)
    }
    
    @objc private func sendMail() {
        guard !(documents.isEmpty) else {return}
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["sulacidi@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            if MFMessageComposeViewController.canSendAttachments() {
                let image = documents[0]
                let dataImage = image.pngData()
                guard dataImage != nil else {return}
                mail.addAttachmentData(dataImage!, mimeType: "image/png", fileName: "ImageData.png")
            }
            present(mail, animated: true)
        } else {
            // show failure alert
        }
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

        return cell
    }
}

extension DocumentsListVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .failed {
            print("could not send message")
        }
        controller.dismiss(animated: true)
    }
}
