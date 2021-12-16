//
//  StoragaManager.swift
//  UserDefaults
//
//  Created by Alik Nigay on 15.12.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "contact"
    
    private init() {}
    
    func save(_ contact: Contact) {
        var contacts = fetchContact()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchContact() -> [Contact] {
        guard let data = userDefaults.data(forKey: key) else { return []}
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    
    func removeContact(_ indexPath: IndexPath) {
        var contacts = fetchContact()
        contacts.remove(at: indexPath.row)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.set(data, forKey: key)
    }
}
