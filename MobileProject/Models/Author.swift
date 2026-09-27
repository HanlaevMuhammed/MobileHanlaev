//
//  Author.swift
//  MobileProject
//

import Foundation

struct Author: Identifiable {
    let id: UUID
    let name: String
    let role: String?
    let imageName: String?

    init(id: UUID = UUID(), name: String, role: String? = nil, imageName: String? = nil) {
        self.id = id
        self.name = name
        self.role = role
        self.imageName = imageName
    }
}

extension Author {
    static let sampleAuthors: [Author] = [
        Author(name: "Ханлаев Мухаммед", role: Strings.authorRoleDeveloper)
    ]
}
