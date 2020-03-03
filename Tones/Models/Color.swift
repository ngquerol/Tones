//
//  Colors.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 27/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

struct Color: Hashable {
    // MARK: Constants

    static let all: [Color] = [
        Color(value: .systemBlue, name: "systemBlue", category: .system),
        Color(value: .systemBrown, name: "systemBrown", category: .system),
        Color(value: .systemGray, name: "systemGray", category: .system),
        Color(value: .systemGreen, name: "systemGreen", category: .system),
        Color(value: .systemOrange, name: "systemOrange", category: .system),
        Color(value: .systemPink, name: "systemPink", category: .system),
        Color(value: .systemPurple, name: "systemPurple", category: .system),
        Color(value: .systemRed, name: "systemRed", category: .system),
        Color(value: .systemYellow, name: "systemYellow", category: .system),
        Color(value: .systemTeal, name: "systemTeal", category: .system),
        Color(value: .systemIndigo, name: "systemIndigo", category: .system),

        Color(value: .black, name: "black", category: .fixed),
        Color(value: .blue, name: "blue", category: .fixed),
        Color(value: .brown, name: "brown", category: .fixed),
        Color(value: .cyan, name: "cyan", category: .fixed),
        Color(value: .darkGray, name: "darkGray", category: .fixed),
        Color(value: .gray, name: "gray", category: .fixed),
        Color(value: .green, name: "green", category: .fixed),
        Color(value: .lightGray, name: "lightGray", category: .fixed),
        Color(value: .magenta, name: "magenta", category: .fixed),
        Color(value: .orange, name: "orange", category: .fixed),
        Color(value: .purple, name: "purple", category: .fixed),
        Color(value: .red, name: "red", category: .fixed),
        Color(value: .white, name: "white", category: .fixed),
        Color(value: .yellow, name: "yellow", category: .fixed),

        Color(value: .labelColor, name: "labelColor", category: .labels),
        Color(value: .secondaryLabelColor, name: "secondaryLabelColor", category: .labels),
        Color(value: .tertiaryLabelColor, name: "tertiaryLabelColor", category: .labels),
        Color(value: .quaternaryLabelColor, name: "quaternaryLabelColor", category: .labels),

        Color(value: .textColor, name: "textColor", category: .text),
        Color(value: .placeholderTextColor, name: "placeholderTextColor", category: .text),
        Color(value: .selectedTextColor, name: "selectedTextColor", category: .text),
        Color(value: .textBackgroundColor, name: "textBackgroundColor", category: .text),
        Color(value: .selectedTextBackgroundColor, name: "selectedTextBackgroundColor", category: .text),
        Color(value: .keyboardFocusIndicatorColor, name: "keyboardFocusIndicatorColor", category: .text),
        Color(value: .unemphasizedSelectedTextColor, name: "unemphasizedSelectedTextColor", category: .text),
        Color(value: .unemphasizedSelectedTextBackgroundColor, name: "unemphasizedSelectedTextBackgroundColor", category: .text),

        Color(value: .linkColor, name: "linkColor", category: .content),
        Color(value: .separatorColor, name: "separatorColor", category: .content),
        Color(value: .selectedContentBackgroundColor, name: "selectedContentBackgroundColor", category: .content),
        Color(value: .unemphasizedSelectedContentBackgroundColor, name: "unemphasizedSelectedContentBackgroundColor", category: .content),

        Color(value: .selectedMenuItemTextColor, name: "selectedMenuItemTextColor", category: .menus),

        Color(value: .gridColor, name: "gridColor", category: .tables),
        Color(value: .headerTextColor, name: "headerTextColor", category: .tables),
        Color(value: NSColor.alternatingContentBackgroundColors[0], name: "alternatingContentBackgroundColors (even)", category: .tables),
        Color(value: NSColor.alternatingContentBackgroundColors[1], name: "alternatingContentBackgroundColors (odd)", category: .tables),

        Color(value: .controlAccentColor, name: "controlAccentColor", category: .controls),
        Color(value: .controlColor, name: "controlColor", category: .controls),
        Color(value: .controlBackgroundColor, name: "controlBackgroundColor", category: .controls),
        Color(value: .controlTextColor, name: "controlTextColor", category: .controls),
        Color(value: .disabledControlTextColor, name: "disabledControlTextColor", category: .controls),
        Color(value: .selectedControlColor, name: "selectedControlColor", category: .controls),
        Color(value: .selectedControlTextColor, name: "selectedControlTextColor", category: .controls),
        Color(value: .alternateSelectedControlTextColor, name: "alternateSelectedControlTextColor", category: .controls),
        Color(value: .scrubberTexturedBackground, name: "scrubberTexturedBackground", category: .controls),

        Color(value: .windowBackgroundColor, name: "windowBackgroundColor", category: .windows),
        Color(value: .windowFrameTextColor, name: "windowFrameTextColor", category: .windows),
        Color(value: .underPageBackgroundColor, name: "underPageBackgroundColor", category: .windows),

        Color(value: .findHighlightColor, name: "findHighlightColor", category: .highlights),
        Color(value: .highlightColor, name: "highlightColor", category: .highlights),
        Color(value: .shadowColor, name: "shadowColor", category: .highlights),

        Color(value: .alternateSelectedControlColor, name: "alternateSelectedControlColor", category: .deprecated),
        Color(value: NSColor.controlAlternatingRowBackgroundColors[0], name: "controlAlternatingRowBackgroundColors (even)", category: .deprecated),
        Color(value: NSColor.controlAlternatingRowBackgroundColors[1], name: "controlAlternatingRowBackgroundColors (odd)", category: .deprecated),
        Color(value: .controlHighlightColor, name: "controlHighlightColor", category: .deprecated),
        Color(value: .controlLightHighlightColor, name: "controlLightHighlightColor", category: .deprecated),
        Color(value: .controlShadowColor, name: "controlShadowColor", category: .deprecated),
        Color(value: .controlDarkShadowColor, name: "controlDarkShadowColor", category: .deprecated),
        Color(value: .headerColor, name: "headerColor", category: .deprecated),
        Color(value: .knobColor, name: "knobColor", category: .deprecated),
        Color(value: .selectedKnobColor, name: "selectedKnobColor", category: .deprecated),
        Color(value: .scrollBarColor, name: "scrollBarColor", category: .deprecated),
        Color(value: .secondarySelectedControlColor, name: "secondarySelectedControlColor", category: .deprecated),
        Color(value: .selectedMenuItemColor, name: "selectedMenuItemColor", category: .deprecated),
        Color(value: .windowFrameColor, name: "windowFrameColor", category: .deprecated),
    ]

    // MARK: Properties

    let value: NSColor
    let name: String
    let category: Color.Category

    // MARK: - Category

    enum Category: CaseIterable, CustomStringConvertible {
        case system
        case fixed
        case labels
        case text
        case content
        case menus
        case tables
        case controls
        case windows
        case highlights
        case deprecated

        var description: String {
            switch self {
            case .system: return "System"
            case .fixed: return "Fixed"
            case .labels: return "Labels"
            case .text: return "Text"
            case .content: return "Content"
            case .menus: return "Menus"
            case .tables: return "Tables"
            case .controls: return "Controls"
            case .windows: return "Windows"
            case .highlights: return "Highlights"
            case .deprecated: return "Deprecated"
            }
        }
    }
}
