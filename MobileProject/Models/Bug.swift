//
//  Bug.swift
//  MobileProject
//

import CoreGraphics
import Foundation

struct Bug: Identifiable {
    let id: UUID
    var position: CGPoint   // logical field coordinates in 0...1 on both axes, NOT device pixels
    var velocity: CGVector  // logical units per second
    let size: CGFloat       // logical units, relative to field width (e.g. 0.08 = 8% of field width)
    let type: BugType

    var imageName: String { type.imageName }
    var points: Int { type.points }

    init(id: UUID = UUID(), position: CGPoint, velocity: CGVector, size: CGFloat, type: BugType) {
        self.id = id
        self.position = position
        self.velocity = velocity
        self.size = size
        self.type = type
    }
}

/// Keep speed/size/points here in sync with the "Виды жуков" section of Resources/rules.html.
enum BugType: CaseIterable {
    case common
    case fast
    case rare

    var speedMultiplier: Double {
        switch self {
        case .common: return 1.0
        case .fast: return 2.2
        case .rare: return 0.6
        }
    }

    var size: CGFloat {
        switch self {
        case .common: return 0.09
        case .fast: return 0.06
        case .rare: return 0.13
        }
    }

    var points: Int {
        switch self {
        case .common: return 10
        case .fast: return 20
        case .rare: return 50
        }
    }

    var imageName: String {
        switch self {
        case .common: return "bug_common"
        case .fast: return "bug_fast"
        case .rare: return "bug_rare"
        }
    }

    var localizedName: String {
        switch self {
        case .common: return Strings.bugTypeCommon
        case .fast: return Strings.bugTypeFast
        case .rare: return Strings.bugTypeRare
        }
    }

    /// Relative spawn weight (higher = more frequent); used by GameEngine's weighted random pick.
    var spawnWeight: Double {
        switch self {
        case .common: return 0.70
        case .fast: return 0.25
        case .rare: return 0.05
        }
    }
}
