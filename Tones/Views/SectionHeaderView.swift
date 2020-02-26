//
//  SectionHeaderView.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class SectionHeaderView: NSView {
    // MARK: IBOutlets

    @IBOutlet var sectionTitleLabel: NSTextField!

    @IBOutlet var sectionItemCountLabel: NSTextField!
}

// MARK: - NSUserInterfaceItemIdentifier

extension NSUserInterfaceItemIdentifier {
    static let sectionHeaderView = NSUserInterfaceItemIdentifier(rawValue: "SectionHeaderView")
}
