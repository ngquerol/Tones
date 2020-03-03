//
//  SystemAppearance.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 29/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

enum SystemAppearance: CaseIterable, RawRepresentable, CustomStringConvertible {
    case light
    case dark

    // MARK: Properties

    var description: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var rawValue: NSAppearance.Name {
        switch self {
        case .light: return .aqua
        case .dark: return .darkAqua
        }
    }

    // MARK: Initializers

    init?(rawValue: NSAppearance.Name) {
        switch rawValue {
        case .aqua: self = .light
        case .darkAqua: self = .dark
        default: return nil
        }
    }
}
