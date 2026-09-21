//
//  Strings.swift
//  MobileProject
//
//  Centralizes Localizable.strings keys so views never contain raw string
//  literals for user-facing text.
//

import Foundation

enum Strings {
    static let formTitle = String(localized: "form.title")
    static let registerButton = String(localized: "form.register.button")

    static let fullNameLabel = String(localized: "form.fullName.label")
    static let fullNamePlaceholder = String(localized: "form.fullName.placeholder")

    static let genderLabel = String(localized: "form.gender.label")

    static let courseLabel = String(localized: "form.course.label")
    static func courseTitle(_ course: Int) -> String {
        String(format: String(localized: "course.format"), course)
    }

    static let difficultyLabel = String(localized: "form.difficulty.label")
    static func difficultyValue(_ value: Int) -> String {
        String(format: String(localized: "difficulty.format"), value)
    }

    static let birthDateLabel = String(localized: "form.birthDate.label")

    static let zodiacLabel = String(localized: "form.zodiac.label")

    static let validationTitle = String(localized: "alert.validation.title")
    static let emptyNameMessage = String(localized: "alert.validation.emptyName")
    static let ok = String(localized: "alert.ok")

    static let resultTitle = String(localized: "form.result.title")
}
