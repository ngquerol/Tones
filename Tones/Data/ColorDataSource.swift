//
//  ColorDataSource.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 27/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

struct ColorDataSource {
    typealias Color = (NSColor, String)

    // MARK: Methods
    
    static subscript(sectionIndex: Int) -> [Color] {
        ColorSection.allCases[sectionIndex].colors
    }

    static subscript(indexPath: IndexPath) -> Color {
        self[indexPath.section][indexPath.item]
    }

    // MARK: Initializer

    private init() {}

    // MARK: - ColorCategory

    enum ColorSection: CaseIterable, CustomStringConvertible {
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
                (.systemBlue, "systemBlue"),
                (.systemBrown, "systemBrown"),
                (.systemGray, "systemGray"),
                (.systemGreen, "systemGreen"),
                (.systemOrange, "systemOrange"),
                (.systemPink, "systemPink"),
                (.systemPurple, "systemPurple"),
                (.systemRed, "systemRed"),
                (.systemYellow, "systemYellow"),
            ]
            case .fixed: return [
                (.black, "black"),
                (.blue, "blue"),
                (.brown, "brown"),
                (.cyan, "cyan"),
                (.darkGray, "darkGray"),
                (.gray, "gray"),
                (.green, "green"),
                (.lightGray, "lightGray"),
                (.magenta, "magenta"),
                (.orange, "orange"),
                (.purple, "purple"),
                (.red, "red"),
                (.white, "white"),
                (.yellow, "yellow"),
            ]
            case .labels: return [
                (.labelColor, "labelColor"),
                (.secondaryLabelColor, "secondaryLabelColor"),
                (.tertiaryLabelColor, "tertiaryLabelColor"),
                (.quaternaryLabelColor, "quaternaryLabelColor"),
            ]
            case .text: return [
                (.textColor, "textColor"),
                (.placeholderTextColor, "placeholderTextColor"),
                (.selectedTextColor, "selectedTextColor"),
                (.textBackgroundColor, "textBackgroundColor"),
                (.selectedTextBackgroundColor, "selectedTextBackgroundColor"),
                (.keyboardFocusIndicatorColor, "keyboardFocusIndicatorColor"),
                (.unemphasizedSelectedTextColor, "unemphasizedSelectedTextColor"),
                (.unemphasizedSelectedTextBackgroundColor, "unemphasizedSelectedTextBackgroundColor"),
            ]
            case .content: return [
                (.linkColor, "linkColor"),
                (.separatorColor, "separatorColor"),
                (.selectedContentBackgroundColor, "selectedContentBackgroundColor"),
                (.unemphasizedSelectedContentBackgroundColor, "unemphasizedSelectedContentBackgroundColor"),
            ]
            case .menus: return [
                (.selectedMenuItemTextColor, "selectedMenuItemTextColor"),
            ]
            case .tables: return [
                (.gridColor, "gridColor"),
                (.headerTextColor, "headerTextColor"),
                (NSColor.alternatingContentBackgroundColors[0], "alternatingContentBackgroundColors (even)"),
                (NSColor.alternatingContentBackgroundColors[1], "alternatingContentBackgroundColors (odd)"),
            ]
            case .controls: return [
                (.controlAccentColor, "controlAccentColor"),
                (.controlColor, "controlColor"),
                (.controlBackgroundColor, "controlBackgroundColor"),
                (.controlTextColor, "controlTextColor"),
                (.disabledControlTextColor, "disabledControlTextColor"),
                (.selectedControlColor, "selectedControlColor"),
                (.selectedControlTextColor, "selectedControlTextColor"),
                (.alternateSelectedControlTextColor, "alternateSelectedControlTextColor"),
                (.scrubberTexturedBackground, "scrubberTexturedBackground"),
            ]
            case .windows: return [
                (.windowBackgroundColor, "windowBackgroundColor"),
                (.windowFrameTextColor, "windowFrameTextColor"),
                (.underPageBackgroundColor, "underPageBackgroundColor"),
            ]
            case .highlights: return [
                (.findHighlightColor, "findHighlightColor"),
                (.highlightColor, "highlightColor"),
                (.shadowColor, "shadowColor"),
            ]
            case .deprecated: return [
                (.alternateSelectedControlColor, "alternateSelectedControlColor"),
                (NSColor.controlAlternatingRowBackgroundColors[0], "controlAlternatingRowBackgroundColors (even)"),
                (NSColor.controlAlternatingRowBackgroundColors[1], "controlAlternatingRowBackgroundColors (odd)"),
                (.controlHighlightColor, "controlHighlightColor"),
                (.controlLightHighlightColor, "controlLightHighlightColor"),
                (.controlShadowColor, "controlShadowColor"),
                (.controlDarkShadowColor, "controlDarkShadowColor"),
                (.headerColor, "headerColor"),
                (.knobColor, "knobColor"),
                (.selectedKnobColor, "selectedKnobColor"),
                (.scrollBarColor, "scrollBarColor"),
                (.secondarySelectedControlColor, "secondarySelectedControlColor"),
                (.selectedMenuItemColor, "selectedMenuItemColor"),
                (.windowFrameColor, "windowFrameColor"),
            ]
            }
        }
    }
}
