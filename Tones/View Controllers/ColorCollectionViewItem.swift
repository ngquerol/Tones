//
//  ColorCollectionViewItem.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorCollectionViewItem: NSCollectionViewItem {
    
    // MARK: IBOutlets
    
    @IBOutlet var colorView: ColorSwatchView!
    
    @IBOutlet var colorLabel: NSTextField!
    
    // MARK: Properties
    
    override var representedObject: Any? {
        didSet {
            guard let color = representedObject as? NSColor else { return }
            
            colorView.representedColor = color
            colorLabel.stringValue = color.colorNameComponent
        }
    }
}

// MARK: - NSUserInterfaceItemIdentifier

extension NSUserInterfaceItemIdentifier {
    static let colorCollectionViewItem = NSUserInterfaceItemIdentifier(rawValue: "ColorCollectionViewItem")
}