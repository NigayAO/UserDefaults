//
//  ViewController.swift
//  UserDefaults
//
//  Created by Alik Nigay on 15.12.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = StorageManager.shared.fetchContact()
        
        title = "Contact List"
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        let contact = contacts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = contact.fullName
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.removeContact(indexPath)
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        showAlert(contact)
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }

}

//MARK: - AlertControllers

extension MainTableViewController {
    func showAlert(_ contact: Contact? = nil) {
        let title = contact != nil ? "Edit" : "New"
        let alert = UIAlertController(title: title, message: "Create new contact", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Name"
            textField.text = contact?.name ?? ""
        }
        alert.addTextField { textField in
            textField.placeholder = "Enter SurName"
            textField.text = contact?.surName ?? ""
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, let surName = alert.textFields?.last?.text else { return }
            let contact = Contact(name: name, surName: surName)
            self.contacts.append(contact)
            StorageManager.shared.save(contact)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
}

