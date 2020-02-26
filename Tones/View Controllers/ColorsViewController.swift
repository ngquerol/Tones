//
//  ColorsViewController.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorsViewController: NSViewController {
    // MARK: IBOutlets

    @IBOutlet var collectionView: NSCollectionView!

    @IBOutlet var appearanceSegmentedControl: NSSegmentedControl! {
        didSet {
            appearanceSegmentedControl.segmentCount = supportedAppearances.count
        }
    }

    @IBOutlet var normalTopMarginConstraint: NSLayoutConstraint!

    @IBOutlet var fullscreenTopMarginConstraint: NSLayoutConstraint!

    // MARK: Properties

    private let supportedAppearances: [NSAppearance.Name] = [.aqua, .darkAqua]

    private let appearanceFriendlyNames: [NSAppearance.Name: String] = [.aqua: "Light", .darkAqua: "Dark"]

    private let sectionNames = [
        "System",
        "Fixed",
        "Labels",
        "Text",
        "Content",
        "Menus",
        "Tables",
        "Controls",
        "Windows",
        "Highlights and Shadows",
        "Deprecated",
    ]

    private let colors: [[(NSColor, String)]] = [
        [
            (.systemBlue, "systemBlue"),
            (.systemBrown, "systemBrown"),
            (.systemGray, "systemGray"),
            (.systemGreen, "systemGreen"),
            (.systemOrange, "systemOrange"),
            (.systemPink, "systemPink"),
            (.systemPurple, "systemPurple"),
            (.systemRed, "systemRed"),
            (.systemYellow, "systemYellow"),
        ],
        [
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
        ],
        [
            (.labelColor, "labelColor"),
            (.secondaryLabelColor, "secondaryLabelColor"),
            (.tertiaryLabelColor, "tertiaryLabelColor"),
            (.quaternaryLabelColor, "quaternaryLabelColor"),
        ],
        [
            (.textColor, "textColor"),
            (.placeholderTextColor, "placeholderTextColor"),
            (.selectedTextColor, "selectedTextColor"),
            (.textBackgroundColor, "textBackgroundColor"),
            (.selectedTextBackgroundColor, "selectedTextBackgroundColor"),
            (.keyboardFocusIndicatorColor, "keyboardFocusIndicatorColor"),
            (.unemphasizedSelectedTextColor, "unemphasizedSelectedTextColor"),
            (.unemphasizedSelectedTextBackgroundColor, "unemphasizedSelectedTextBackgroundColor"),
        ],
        [
            (.linkColor, "linkColor"),
            (.separatorColor, "separatorColor"),
            (.selectedContentBackgroundColor, "selectedContentBackgroundColor"),
            (.unemphasizedSelectedContentBackgroundColor, "unemphasizedSelectedContentBackgroundColor"),
        ],
        [
            (.selectedMenuItemTextColor, "selectedMenuItemTextColor"),
        ],
        [
            (.gridColor, "gridColor"),
            (.headerTextColor, "headerTextColor"),
            (NSColor.alternatingContentBackgroundColors[0], "alternatingContentBackgroundColors (even)"),
            (NSColor.alternatingContentBackgroundColors[1], "alternatingContentBackgroundColors (odd)"),
        ],
        [
            (.controlAccentColor, "controlAccentColor"),
            (.controlColor, "controlColor"),
            (.controlBackgroundColor, "controlBackgroundColor"),
            (.controlTextColor, "controlTextColor"),
            (.disabledControlTextColor, "disabledControlTextColor"),
            (.selectedControlColor, "selectedControlColor"),
            (.selectedControlTextColor, "selectedControlTextColor"),
            (.alternateSelectedControlTextColor, "alternateSelectedControlTextColor"),
            (.scrubberTexturedBackground, "scrubberTexturedBackground"),
        ],
        [
            (.windowBackgroundColor, "windowBackgroundColor"),
            (.windowFrameTextColor, "windowFrameTextColor"),
            (.underPageBackgroundColor, "underPageBackgroundColor"),
        ],
        [
            (.findHighlightColor, "findHighlightColor"),
            (.highlightColor, "highlightColor"),
            (.shadowColor, "shadowColor"),
        ],
        [
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
        ],
    ]

    private var keyValueObservation: NSKeyValueObservation?

    // MARK: View lifecycle

    override func viewWillAppear() {
        super.viewWillAppear()

        keyValueObservation = NSApp.observe(
            \.effectiveAppearance,
            options: [.initial, .new],
            changeHandler: updateAppearanceSegmentedControl(_:change:)
        )

        NotificationCenter.default.addObserver(forName: NSWindow.willEnterFullScreenNotification, object: nil, queue: .main) { _ in
            self.normalTopMarginConstraint.priority = .defaultLow
            self.fullscreenTopMarginConstraint.priority = .defaultHigh
        }

        NotificationCenter.default.addObserver(forName: NSWindow.willExitFullScreenNotification, object: nil, queue: .main) { _ in
            self.normalTopMarginConstraint.priority = .defaultHigh
            self.fullscreenTopMarginConstraint.priority = .defaultLow
        }
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()

        keyValueObservation = nil

        NotificationCenter.default.removeObserver(self, name: NSWindow.willEnterFullScreenNotification, object: nil)

        NotificationCenter.default.removeObserver(self, name: NSWindow.willExitFullScreenNotification, object: nil)
    }

    // MARK: Actions

    @IBAction func userDidSelectAppearance(_ sender: NSSegmentedControl) {
        view.window?.appearance = NSAppearance(named: supportedAppearances[sender.selectedSegment])
    }

    // MARK: Methods

    private func updateAppearanceSegmentedControl(_: NSApplication, change: NSKeyValueObservedChange<NSAppearance>) {
        let systemAppearance = change.newValue?.name

        for i in 0 ..< supportedAppearances.count {
            let appearance = supportedAppearances[i]

            if appearance == systemAppearance {
                appearanceSegmentedControl.setLabel("\(appearanceFriendlyNames[appearance, default: appearance.rawValue]) (System)", forSegment: i)
                appearanceSegmentedControl.selectedSegment = i
            } else {
                appearanceSegmentedControl.setLabel(appearanceFriendlyNames[appearance, default: appearance.rawValue], forSegment: i)
            }

            appearanceSegmentedControl.setWidth(0, forSegment: i)
        }
    }
}

// MARK: - NSCollectionViewDataSource

extension ColorsViewController: NSCollectionViewDataSource {
    func numberOfSections(in _: NSCollectionView) -> Int {
        colors.count
    }

    func collectionView(_: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors[section].count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .colorCollectionViewItem, for: indexPath)

        guard let collectionViewItem = item as? ColorCollectionViewItem else { return item }
        
        let color = colors[indexPath.section][indexPath.item]

        collectionViewItem.colorView.representedColor = color.0
        collectionViewItem.colorLabel.stringValue = color.1

        return collectionViewItem
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: .sectionHeaderView, for: indexPath)

        guard let sectionHeaderView = view as? SectionHeaderView else { return view }

        sectionHeaderView.sectionTitleLabel.stringValue = sectionNames[indexPath.section]
        sectionHeaderView.sectionItemCountLabel.stringValue = "\(colors[indexPath.section].count) colors"

        return sectionHeaderView
    }
}
