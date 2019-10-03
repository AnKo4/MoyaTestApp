//
//  DeletePostViewController.swift
//  MoyaTestApp
//
//  Created by Andrey on 03/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class DeletePostViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    
    @IBOutlet private weak var serverResponseLabel: UILabel!
    
    let networkManager = NetworkManager()
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        if let str = idTextField.text, let id = Int(str) {
            networkManager.deletePost(id: id) { [weak self] status in
                guard let self = self else { return }
                self.serverResponseLabel.text = status
            }
        } else {
            serverResponseLabel.text = "Введите корректный id"
        }
    }
    
}
