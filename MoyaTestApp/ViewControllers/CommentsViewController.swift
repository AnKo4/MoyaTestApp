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

        setupTable()
        viewModel.configure() { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        tableView.dataSource = self
    }
    
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        cell.textLabel?.text = "\(viewModel.data[indexPath.row].id). \(viewModel.data[indexPath.row].email)"
        return cell
    }
    
    
}
