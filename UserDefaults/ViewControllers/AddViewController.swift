//
//  AddViewController.swift
//  UserDefaults
//
//  Created by Alik Nigay on 16.12.2021.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    
    var delegate: AddViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        nameTF.addTarget(self,
                         action: #selector(nameTFChanged),
                         for: .editingChanged)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let name = nameTF.text, let surName = surNameTF.text else { return }
        let contact = Contact(name: name, surName: surName)
        StorageManager.shared.save(contact)
        delegate.save(contact)
        dismiss(animated: true)
    }
    
    @objc private func nameTFChanged() {
        guard let name = nameTF.text else { return }
        saveButton.isEnabled = !name.isEmpty
    }
}
