//
//  ColorCollectionViewItem.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorCollectionViewItem: NSCollectionViewItem {
    
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "ColorCollectionViewItem")
    
    // MARK: IBOutlets
    
    @IBOutlet var colorView: ColorSwatchView!
    
    @IBOutlet var colorLabel: NSTextField!
}
