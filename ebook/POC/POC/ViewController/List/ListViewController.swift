//
//  ListViewController.swift
//  POC
//
//  Created by Cheryl Chen on 2020/3/24.
//  Copyright © 2020 Cheryl Chen. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private Variable
    lazy private var viewModel = {
        return ListViewModel()
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private Function
    private func setup() {
        bindViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: ListCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: ListCell.self))
    }
    
    private func bindViewModel() {
        viewModel.showIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator.isHidden = false
                self?.indicator.startAnimating()
            }
        }
        viewModel.hideIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator.isHidden = true
                self?.indicator.stopAnimating()
            }
        }
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.load()
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCell.self), for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let vm = viewModel.getCellViewModel(at: indexPath)
        cell.avatarImageView.kf.setImage(with: URL(string: vm.avatarURL),
                                         placeholder: UIImage(named: "avatar.jpg"))
        cell.config(title: "#\(indexPath.row + 1) \(vm.login)",
                    badge: vm.siteAdmin ? "Admin" : nil)
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
