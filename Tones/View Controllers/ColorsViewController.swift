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

    @IBOutlet var collectionView: NSCollectionView! {
        didSet {
            collectionView.dataSource = dataSource
        }
    }

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

    private let dataSource: NSCollectionViewDataSource = ColorsDataSource()

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
