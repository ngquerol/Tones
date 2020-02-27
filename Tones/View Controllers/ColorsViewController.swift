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

            for i in 0 ..< appearanceSegmentedControl.segmentCount {
                appearanceSegmentedControl.setWidth(0, forSegment: i)
            }
        }
    }

    @IBOutlet var normalTopMarginConstraint: NSLayoutConstraint!

    @IBOutlet var fullscreenTopMarginConstraint: NSLayoutConstraint!

    // MARK: Properties

    private let supportedAppearances: [NSAppearance.Name] = [.aqua, .darkAqua]

    private let friendlyAppearanceNames: [NSAppearance.Name: String] = [.aqua: "Light", .darkAqua: "Dark"]

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
                appearanceSegmentedControl.setLabel("\(friendlyAppearanceNames[appearance, default: appearance.rawValue]) (System)", forSegment: i)
                appearanceSegmentedControl.selectedSegment = i
            } else {
                appearanceSegmentedControl.setLabel(friendlyAppearanceNames[appearance, default: appearance.rawValue], forSegment: i)
            }
        }
    }
}

// MARK: - NSCollectionViewDataSource

extension ColorsViewController: NSCollectionViewDataSource {
    func numberOfSections(in _: NSCollectionView) -> Int {
        ColorDataSource.ColorSection.allCases.count
    }

    func collectionView(_: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        ColorDataSource[section].count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .colorCollectionViewItem, for: indexPath)

        guard let collectionViewItem = item as? ColorCollectionViewItem else { return item }

        let (color, name) = ColorDataSource[indexPath]

        collectionViewItem.colorView.representedColor = color
        collectionViewItem.colorLabel.stringValue = name

        return collectionViewItem
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(
            ofKind: kind,
            withIdentifier: .sectionHeaderView,
            for: indexPath
        )

        guard let sectionHeaderView = view as? SectionHeaderView else { return view }

        let category = ColorDataSource.ColorSection.allCases[indexPath.section]

        sectionHeaderView.sectionTitleLabel.stringValue = category.description
        sectionHeaderView.sectionItemCountLabel.stringValue = "\(category.colors.count) color(s)"

        return sectionHeaderView
    }
}
