//
//  TrailersListVC.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/17/23.
//

import UIKit

class TrailersListVC: UIViewController {
    
    let tableView = UITableView()
    let trailers = Trailers()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Trailers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TrailerCell.self, forCellReuseIdentifier: TrailerCell.reuseID)
    }
    
}

extension TrailersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.trailerNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrailerCell.reuseID) as! TrailerCell
        let trailer = trailers.trailerNames[indexPath.row]
        cell.trailerNameLabel.text = trailer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let documentsListVC = DocumentsListVC()
        tableView.deselectRow(at: indexPath, animated: false)
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.navigationController?.pushViewController(documentsListVC, animated: true)
        }
    }
}
