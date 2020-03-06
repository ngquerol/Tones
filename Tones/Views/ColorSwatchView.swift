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

    // MARK: Initializers

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        wantsLayer = true
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Methods

    override var wantsUpdateLayer: Bool { true }

    override func updateLayer() {
        layer?.cornerRadius = 5
        layer?.borderWidth = 1
        layer?.borderColor = representedColor?.withSystemEffect(.pressed).cgColor
        layer?.backgroundColor = representedColor?.cgColor
    }
}
