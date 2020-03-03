//
//  ColorCollectionViewItem.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 03/03/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorCollectionViewItem: NSCollectionViewItem {
    // MARK: Constants

    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "ColorCollectionViewItem")

    // MARK: IBOutlets

    @IBOutlet var colorView: ColorSwatchView!

    @IBOutlet var colorLabel: NSTextField!
}
