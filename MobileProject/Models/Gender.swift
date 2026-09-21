//
//  Gender.swift
//  MobileProject
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male
    case female

    var id: String { rawValue }

    var localizedName: String {
        switch self {
        case .male:
            return String(localized: "gender.male")
        case .female:
            return String(localized: "gender.female")
        }
    }
}
