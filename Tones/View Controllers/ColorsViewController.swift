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

    // MARK: Properties

    private let supportedAppearances: [NSAppearance.Name] = [.aqua, .darkAqua]

    private let appearanceFriendlyNames: [NSAppearance.Name: String] = [.aqua: "Light", .darkAqua: "Dark"]

    private let sectionNames = ["System", "Controls"]

    private let colors: [[NSColor]] = [
        [
            .systemBlue,
            .systemBrown,
            .systemGray,
            .systemGreen,
            .systemIndigo,
            .systemOrange,
            .systemPink,
            .systemPurple,
            .systemRed,
            .systemTeal,
            .systemYellow,
        ],
        [
            .alternateSelectedControlColor,
            .alternateSelectedControlTextColor,
            .controlAccentColor,
            .controlBackgroundColor,
            .controlDarkShadowColor,
            .controlHighlightColor,
            .controlLightHighlightColor,
            .controlShadowColor,
            .controlTextColor,
            .disabledControlTextColor,
            .secondarySelectedControlColor,
            .selectedControlColor,
            .selectedControlTextColor,
            .controlColor,
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
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        keyValueObservation = nil
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

        collectionViewItem.representedObject = colors[indexPath.section][indexPath.item]

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
