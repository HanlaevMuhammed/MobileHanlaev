//
//  Player.swift
//  MobileProject
//

import Foundation

struct Player {
    let fullName: String
    let gender: Gender
    let course: Int
    let difficulty: Int
    let birthDate: Date
    let zodiacSign: ZodiacSign

    var formattedSummary: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        return String(
            format: String(localized: "summary.format"),
            fullName,
            gender.localizedName,
            course,
            difficulty,
            dateFormatter.string(from: birthDate),
            zodiacSign.localizedName
        )
    }
}
