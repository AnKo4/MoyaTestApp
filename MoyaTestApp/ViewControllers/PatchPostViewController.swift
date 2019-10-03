//
//  PatchPostViewController.swift
//  MoyaTestApp
//
//  Created by Andrey on 03/10/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class PatchPostViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    @IBOutlet private weak var userIdTextField: UITextField!
    
    @IBOutlet weak var serverResponseLabel: UILabel!
    
    let networkManager = NetworkManager()

    @IBAction private func buttonTapped(_ sender: UIButton) {
        let id = Int(idTextField.text ?? "1") ?? 1
        let title = titleTextField.text
        let body = bodyTextField.text
        // Сервер требует чтобы userId был Int
        let userId = userIdTextField.text != nil ? Int(userIdTextField.text ?? "") : nil
        
        networkManager.patchPost(id: id, title: title, body: body, userId: userId) { [weak self] status, response in
            guard let self = self else { return }
            self.serverResponseLabel.text = "status: \(status)\n\nid: \(response.id)\ntitle: \(response.title)\nbody: \(response.body)\nuserId: \(response.userId)"

        }
    }
    
}
