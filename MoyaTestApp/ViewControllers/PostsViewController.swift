//
//  PostsViewController.swift
//  MoyaTestApp
//
//  Created by Andrey on 01/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = PostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}


extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        cell.textLabel?.text = "\(viewModel.data[indexPath.row].id). \(viewModel.data[indexPath.row].body)"
        return cell
    }
    
}

extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: ViewModelDelegate {
    func refreshScreen() {
        tableView.reloadData()
    }
}
