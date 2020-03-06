//
//  SystemAppearanceViewController.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 03/03/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class SystemAppearanceViewController: NSViewController {
    // MARK: IBOutlets

    @IBOutlet var segmentedControl: NSSegmentedControl! {
        didSet {
            segmentedControl.segmentCount = SystemAppearance.allCases.count

            for i in 0 ..< SystemAppearance.allCases.count {
                segmentedControl.setWidth(0, forSegment: i)
            }
        }
    }

    // MARK: IBActions

    @IBAction func userDidSelectAppearance(_ sender: NSSegmentedControl) {
        let systemAppearance = SystemAppearance.allCases[sender.selectedSegment]
        view.window?.appearance = NSAppearance(named: systemAppearance.rawValue)
    }

    // MARK: Properties

    private var keyValueObservation: NSKeyValueObservation?

    // MARK: View lifecycle

    override func viewWillAppear() {
        keyValueObservation = NSApp.observe(
            \.effectiveAppearance.name,
            options: [.initial, .new],
            changeHandler: systemAppearanceChangeHandler
        )
    }

    override func viewWillDisappear() {
        keyValueObservation = nil
    }

    // MARK: Methods

    private func systemAppearanceChangeHandler(_: NSApplication, change: NSKeyValueObservedChange<NSAppearance.Name>) {
        guard let systemAppearanceName = change.newValue else { return }

        for (i, appearance) in SystemAppearance.allCases.enumerated() {
            if appearance == SystemAppearance(rawValue: systemAppearanceName) {
                segmentedControl.setLabel("\(appearance.description) (System)", forSegment: i)
                segmentedControl.selectedSegment = i
            } else {
                segmentedControl.setLabel(appearance.description, forSegment: i)
            }
        }
    }
}
