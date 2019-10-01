//
//  CommentsViewController.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = CommentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        cell.textLabel?.text = "\(viewModel.data[indexPath.row].id). \(viewModel.data[indexPath.row].body)"
        return cell
    }
    
    
}

extension CommentsViewController: UITableViewDelegate {
    
}

extension CommentsViewController: ViewModelDelegate {
    func refreshScreen() {
        tableView.reloadData()
    }
    
    
}

