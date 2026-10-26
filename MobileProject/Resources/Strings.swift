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

    static let gameTabTitle = String(localized: "tab.game")
    static let recordsTabTitle = String(localized: "tab.records")
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

    // MARK: - Game

    static let gameMenuTitle = String(localized: "game.menu.title")
    static let gameScoreLabel = String(localized: "game.score.label")
    static let gameHitsLabel = String(localized: "game.hits.label")
    static let gameMissesLabel = String(localized: "game.misses.label")
    static func gameTimeValue(_ value: Double) -> String {
        String(format: String(localized: "game.time.label"), value)
    }
    static let gameStartButton = String(localized: "game.start.button")
    static let gameStopButton = String(localized: "game.stop.button")

    // MARK: - Bug types

    static let bugTypeCommon = String(localized: "bug.type.common")
    static let bugTypeFast = String(localized: "bug.type.fast")
    static let bugTypeRare = String(localized: "bug.type.rare")

    // MARK: - Game result

    static let gameResultTitle = String(localized: "result.title")
    static func gameResultScoreValue(_ value: Int) -> String {
        String(format: String(localized: "result.score.format"), value)
    }
    static func gameResultHitsValue(_ value: Int) -> String {
        String(format: String(localized: "result.hits.format"), value)
    }
    static func gameResultMissesValue(_ value: Int) -> String {
        String(format: String(localized: "result.misses.format"), value)
    }
    static func gameResultAccuracyValue(_ value: Double) -> String {
        String(format: String(localized: "result.accuracy.format"), value)
    }
    static let gameResultPlayAgainButton = String(localized: "result.playAgain.button")
    static let gameResultBackButton = String(localized: "result.back.button")

    // MARK: - Records

    static let recordsTitle = String(localized: "records.title")
    static let recordsEmpty = String(localized: "records.empty")
    static func recordsDifficultyValue(_ value: Int) -> String {
        String(format: String(localized: "records.difficulty.format"), value)
    }
    static func recordsDateValue(_ value: String) -> String {
        String(format: String(localized: "records.date.format"), value)
    }
    static let recordsSortLabel = String(localized: "records.sort.label")
    static let recordsSortByScore = String(localized: "records.sort.byScore")
    static let recordsSortByDate = String(localized: "records.sort.byDate")
    static let recordsFilterLabel = String(localized: "records.filter.label")
    static let recordsFilterAll = String(localized: "records.filter.all")

    // MARK: - Player selection

    static let playerSelectionTitle = String(localized: "player.selection.title")
    static let playerSelectionNew = String(localized: "player.selection.new")
    static func playerSelectionCurrent(_ name: String) -> String {
        String(format: String(localized: "player.selection.current.format"), name)
    }
    static let playerSelectionChange = String(localized: "player.selection.change")
    static let playerSelectionNone = String(localized: "player.selection.none")

    // MARK: - Game / save errors

    static let gameSaveError = String(localized: "game.save.error")
    static let gameNoPlayer = String(localized: "game.noPlayer")
}
