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

    // MARK: - Tabs

    static let registrationTabTitle = String(localized: "tab.registration")
    static let rulesTabTitle = String(localized: "tab.rules")
    static let authorsTabTitle = String(localized: "tab.authors")
    static let settingsTabTitle = String(localized: "tab.settings")

    // MARK: - Authors

    static let authorRoleDeveloper = String(localized: "authors.row.role.developer")
    static let authorsPlaceholderRole = String(localized: "authors.placeholder")

    // MARK: - Settings

    static let settingsSectionTitle = String(localized: "settings.section.title")

    static let speedLabel = String(localized: "settings.speed.label")
    static func speedValue(_ value: Double) -> String {
        String(format: String(localized: "settings.speed.format"), value)
    }

    static let maxCockroachesLabel = String(localized: "settings.maxCockroaches.label")
    static func maxCockroachesValue(_ value: Int) -> String {
        String(format: String(localized: "settings.maxCockroaches.format"), value)
    }

    static let bonusIntervalLabel = String(localized: "settings.bonusInterval.label")
    static func bonusIntervalValue(_ value: Double) -> String {
        String(format: String(localized: "settings.bonusInterval.format"), value)
    }

    static let roundDurationLabel = String(localized: "settings.roundDuration.label")
    static func roundDurationValue(_ value: Double) -> String {
        String(format: String(localized: "settings.roundDuration.format"), value)
    }
}
