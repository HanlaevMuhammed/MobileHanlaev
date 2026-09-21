//
//  ZodiacSign.swift
//  MobileProject
//

import Foundation

enum ZodiacSign: String, CaseIterable, Identifiable {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces

    var id: String { rawValue }

    var localizedName: String {
        switch self {
        case .aries:
            return String(localized: "zodiac.aries")
        case .taurus:
            return String(localized: "zodiac.taurus")
        case .gemini:
            return String(localized: "zodiac.gemini")
        case .cancer:
            return String(localized: "zodiac.cancer")
        case .leo:
            return String(localized: "zodiac.leo")
        case .virgo:
            return String(localized: "zodiac.virgo")
        case .libra:
            return String(localized: "zodiac.libra")
        case .scorpio:
            return String(localized: "zodiac.scorpio")
        case .sagittarius:
            return String(localized: "zodiac.sagittarius")
        case .capricorn:
            return String(localized: "zodiac.capricorn")
        case .aquarius:
            return String(localized: "zodiac.aquarius")
        case .pisces:
            return String(localized: "zodiac.pisces")
        }
    }

    var imageName: String {
        "zodiac_\(rawValue)"
    }

    /// Determines the zodiac sign for a given birth date using calendar day-of-year
    /// boundaries only (no hardcoded month/day strings, no locale-dependent formatting).
    static func from(date: Date) -> ZodiacSign {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day], from: date)
        guard let month = components.month, let day = components.day else {
            return .aries
        }

        switch (month, day) {
        case (3, 21...31), (4, 1...19):
            return .aries
        case (4, 20...30), (5, 1...20):
            return .taurus
        case (5, 21...31), (6, 1...20):
            return .gemini
        case (6, 21...30), (7, 1...22):
            return .cancer
        case (7, 23...31), (8, 1...22):
            return .leo
        case (8, 23...31), (9, 1...22):
            return .virgo
        case (9, 23...30), (10, 1...22):
            return .libra
        case (10, 23...31), (11, 1...21):
            return .scorpio
        case (11, 22...30), (12, 1...21):
            return .sagittarius
        case (12, 22...31), (1, 1...19):
            return .capricorn
        case (1, 20...31), (2, 1...18):
            return .aquarius
        default:
            return .pisces
        }
    }
}
