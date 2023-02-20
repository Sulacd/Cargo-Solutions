//
//  LoginVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 11/17/22.
//

import UIKit

class LoginVC: UIViewController {
    
//MARK: - UI & Model Properties
    // UI Elements
    let logoImageView = UIImageView()
    let usernameTextField = CSTextField()
    let callToActionButton = CSButton(color: .systemBlue, title: "Login", systemImageName: "person.crop.circle.badge.checkmark")
    let tableView = UITableView()
    
    // Models
    let trailers = Trailers()
    
//MARK: - Lifecycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        // Hides the nav bar whenever the search view is displayed
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        createDismissKeyboardTapGesture()
    }
    
//MARK: - Utility Methods and Properties
    
    // Dismisses the keyboard when user taps outside of it
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    @objc private func pushTrailersListVC() {
        guard isUsernameEntered else {
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let trailersListVC = TrailersListVC()
        navigationController?.pushViewController(trailersListVC, animated: true)
        
    }
    
//MARK: - UI Configuration Methods
    
    private func configure() {
        view.addSubViews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureCSTextField()
        configureCallToActionButton()
    }
    
    private func configureLogoImageView() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "CSLogo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 280),
            logoImageView.widthAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    private func configureCSTextField() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 0),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushTrailersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 200),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


