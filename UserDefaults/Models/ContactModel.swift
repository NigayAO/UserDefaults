//
//  ContactModel.swift
//  UserDefaults
//
//  Created by Alik Nigay on 15.12.2021.
//
struct Contact: Codable {
    var name: String
    var surName: String
    
    var fullName: String {
        "\(name) \(surName)"
    }
}
