//
//  Colors.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 27/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

struct Color {
    let value: NSColor
    let name: String
}

struct Colors {
    // MARK: Methods

    static subscript(sectionIndex: Int) -> Category {
        Category.allCases[sectionIndex]
    }

    static subscript(indexPath: IndexPath) -> Color {
        self[indexPath.section].colors[indexPath.item]
    }

    // MARK: Initializer

    private init() {}

    // MARK: Category

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

        var colors: [Color] {
            switch self {
            case .system: return [
                Color(value: .systemBlue, name: "systemBlue"),
                Color(value: .systemBrown, name: "systemBrown"),
                Color(value: .systemGray, name: "systemGray"),
                Color(value: .systemGreen, name: "systemGreen"),
                Color(value: .systemOrange, name: "systemOrange"),
                Color(value: .systemPink, name: "systemPink"),
                Color(value: .systemPurple, name: "systemPurple"),
                Color(value: .systemRed, name: "systemRed"),
                Color(value: .systemYellow, name: "systemYellow"),
                Color(value: .systemTeal, name: "systemTeal"),
                Color(value: .systemIndigo, name: "systemIndigo"),
            ]
            case .fixed: return [
                Color(value: .black, name: "black"),
                Color(value: .blue, name: "blue"),
                Color(value: .brown, name: "brown"),
                Color(value: .cyan, name: "cyan"),
                Color(value: .darkGray, name: "darkGray"),
                Color(value: .gray, name: "gray"),
                Color(value: .green, name: "green"),
                Color(value: .lightGray, name: "lightGray"),
                Color(value: .magenta, name: "magenta"),
                Color(value: .orange, name: "orange"),
                Color(value: .purple, name: "purple"),
                Color(value: .red, name: "red"),
                Color(value: .white, name: "white"),
                Color(value: .yellow, name: "yellow"),
            ]
            case .labels: return [
                Color(value: .labelColor, name: "labelColor"),
                Color(value: .secondaryLabelColor, name: "secondaryLabelColor"),
                Color(value: .tertiaryLabelColor, name: "tertiaryLabelColor"),
                Color(value: .quaternaryLabelColor, name: "quaternaryLabelColor"),
            ]
            case .text: return [
                Color(value: .textColor, name: "textColor"),
                Color(value: .placeholderTextColor, name: "placeholderTextColor"),
                Color(value: .selectedTextColor, name: "selectedTextColor"),
                Color(value: .textBackgroundColor, name: "textBackgroundColor"),
                Color(value: .selectedTextBackgroundColor, name: "selectedTextBackgroundColor"),
                Color(value: .keyboardFocusIndicatorColor, name: "keyboardFocusIndicatorColor"),
                Color(value: .unemphasizedSelectedTextColor, name: "unemphasizedSelectedTextColor"),
                Color(value: .unemphasizedSelectedTextBackgroundColor, name: "unemphasizedSelectedTextBackgroundColor"),
            ]
            case .content: return [
                Color(value: .linkColor, name: "linkColor"),
                Color(value: .separatorColor, name: "separatorColor"),
                Color(value: .selectedContentBackgroundColor, name: "selectedContentBackgroundColor"),
                Color(value: .unemphasizedSelectedContentBackgroundColor, name: "unemphasizedSelectedContentBackgroundColor"),
            ]
            case .menus: return [
                Color(value: .selectedMenuItemTextColor, name: "selectedMenuItemTextColor"),
            ]
            case .tables: return [
                Color(value: .gridColor, name: "gridColor"),
                Color(value: .headerTextColor, name: "headerTextColor"),
                Color(value: NSColor.alternatingContentBackgroundColors[0], name: "alternatingContentBackgroundColors (even)"),
                Color(value: NSColor.alternatingContentBackgroundColors[1], name: "alternatingContentBackgroundColors (odd)"),
            ]
            case .controls: return [
                Color(value: .controlAccentColor, name: "controlAccentColor"),
                Color(value: .controlColor, name: "controlColor"),
                Color(value: .controlBackgroundColor, name: "controlBackgroundColor"),
                Color(value: .controlTextColor, name: "controlTextColor"),
                Color(value: .disabledControlTextColor, name: "disabledControlTextColor"),
                Color(value: .selectedControlColor, name: "selectedControlColor"),
                Color(value: .selectedControlTextColor, name: "selectedControlTextColor"),
                Color(value: .alternateSelectedControlTextColor, name: "alternateSelectedControlTextColor"),
                Color(value: .scrubberTexturedBackground, name: "scrubberTexturedBackground"),
            ]
            case .windows: return [
                Color(value: .windowBackgroundColor, name: "windowBackgroundColor"),
                Color(value: .windowFrameTextColor, name: "windowFrameTextColor"),
                Color(value: .underPageBackgroundColor, name: "underPageBackgroundColor"),
            ]
            case .highlights: return [
                Color(value: .findHighlightColor, name: "findHighlightColor"),
                Color(value: .highlightColor, name: "highlightColor"),
                Color(value: .shadowColor, name: "shadowColor"),
            ]
            case .deprecated: return [
                Color(value: .alternateSelectedControlColor, name: "alternateSelectedControlColor"),
                Color(value: NSColor.controlAlternatingRowBackgroundColors[0], name: "controlAlternatingRowBackgroundColors (even)"),
                Color(value: NSColor.controlAlternatingRowBackgroundColors[1], name: "controlAlternatingRowBackgroundColors (odd)"),
                Color(value: .controlHighlightColor, name: "controlHighlightColor"),
                Color(value: .controlLightHighlightColor, name: "controlLightHighlightColor"),
                Color(value: .controlShadowColor, name: "controlShadowColor"),
                Color(value: .controlDarkShadowColor, name: "controlDarkShadowColor"),
                Color(value: .headerColor, name: "headerColor"),
                Color(value: .knobColor, name: "knobColor"),
                Color(value: .selectedKnobColor, name: "selectedKnobColor"),
                Color(value: .scrollBarColor, name: "scrollBarColor"),
                Color(value: .secondarySelectedControlColor, name: "secondarySelectedControlColor"),
                Color(value: .selectedMenuItemColor, name: "selectedMenuItemColor"),
                Color(value: .windowFrameColor, name: "windowFrameColor"),
            ]
            }
        }
    }
}
