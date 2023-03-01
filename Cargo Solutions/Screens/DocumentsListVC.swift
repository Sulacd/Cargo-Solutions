//
//  DocumentsListVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/19/23.
//

import UIKit
import VisionKit
import MessageUI
import PDFKit

class DocumentsListVC: UIViewController {
    
// MARK: - UI & Model Propertiess
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Document>!
    var csToolBar: CSToolBar!
    
    var documents: [Document] = []
    
// MARK: - Utility Properties
    var numOfDocuments = 0
    
    enum Section {
        case main
    }
    
// MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(presentDocumentVC))
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        configureToolBar()
        configureViewController()
    }
    
// MARK: - UI Configuration Methods

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
        
        collectionView.register(DocumentCell.self, forCellWithReuseIdentifier: DocumentCell.reuseID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureToolBar() {
        csToolBar = CSToolBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sendButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendMail))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(sendMail))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeDocuments))
        
        csToolBar.setItems([editButton, flexibleButton, sendButton, flexibleButton, deleteButton], animated: true)
    }
    
//MARK: - Data Source Configuration Methods
    
    // Function that connects a diffable data source to our collection view
    func configureDataSource() {
        // dataSource's cellprovider closure is called for eaach cell displayed on the UI
        dataSource = UICollectionViewDiffableDataSource<Section, Document>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            // Configures our collection view with a Follower Cell. The follower cell defines how to display the cell on the UI.
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentCell.reuseID, for: indexPath) as! DocumentCell
            cell.documentImageView.image = self.documents[indexPath.row].image
            return cell
        })
    }
    
    func updateData(on documents: [Document]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Document>()
        // Feeds data to a snapshot that will be applied to the diffable data source
        snapshot.appendSections([.main])
        snapshot.appendItems(documents, toSection: .main)
        DispatchQueue.main.async {
            // Applies the data, calls dataSource's closure for each cell and displays the results to the UI
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

//MARK: - Utility Methods
    
    @objc private func presentDocumentVC() {
        documents = []
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate = self
        self.present(scanningDocumentVC, animated: true)
    }
    
    @objc private func sendMail() {
        guard !(documents.isEmpty) else {return}
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["sulacidi@gmail.com"])
            //mail.setMessageBody("", isHTML: true)
            
            if MFMessageComposeViewController.canSendAttachments() {
                var documentImages: [UIImage] = []
                for document in documents {
                    documentImages.append(document.image)
                }
                let pdfDocument = documentImages.makePDF()
                let data = pdfDocument?.dataRepresentation()
                guard data != nil else {return}
                mail.addAttachmentData(data!, mimeType: "application/pdf", fileName: "ImageData.pdf")
            }
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc private func removeDocuments() {
        documents = []
        updateData(on: documents)
    }
}

//MARK: - Extensions

extension DocumentsListVC: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        numOfDocuments = scan.pageCount
        for pageNum in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNum)
            let document = Document(image: image)
            documents.append(document)
        }
        updateData(on: documents)
        controller.dismiss(animated: true)
    }
}

extension DocumentsListVC: UICollectionViewDelegate {
  
}

extension DocumentsListVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .failed {
            print("could not send message")
        }
        controller.dismiss(animated: true)
    }
}
