//
//  ViewController.swift
//  UserDefaults
//
//  Created by Alik Nigay on 15.12.2021.
//

import UIKit

protocol AddViewControllerDelegate {
    func save(_ contact: Contact)
}

class MainTableViewController: UITableViewController {
    
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = StorageManager.shared.fetchContact()
        
        title = "Contact List"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addVC = segue.destination as? AddViewController else { return }
        addVC.delegate = self
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - MainTableViewControllerDelegate
extension MainTableViewController: AddViewControllerDelegate {
    func save(_ contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
}

