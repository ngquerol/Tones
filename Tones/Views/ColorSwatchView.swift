//
//  ColorSwatchView.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorSwatchView: NSView {
    // MARK: Properties

    var representedColor: NSColor?

    // MARK: Methods

    override func draw(_ dirtyRect: NSRect) {
        guard
            let color = representedColor,
            let cgContext = NSGraphicsContext.current?.cgContext
        else {
            return
        }

        let roundRectPath = CGPath(
            roundedRect: dirtyRect.insetBy(
                dx: 10,
                dy: 10
            ),
            cornerWidth: 5,
            cornerHeight: 5,
            transform: nil
        )

        cgContext.saveGState()

        cgContext.addPath(roundRectPath)
        cgContext.clip()

        cgContext.setFillColor(color.cgColor)
        cgContext.fill(dirtyRect)
        
        cgContext.addPath(roundRectPath)
        cgContext.setLineWidth(3)
        cgContext.setStrokeColor(color.withSystemEffect(.pressed).cgColor)
        cgContext.strokePath()

        cgContext.restoreGState()
    }
}
