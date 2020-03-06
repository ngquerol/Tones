//
//  ContainerViewController.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 03/03/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ContainerViewController: NSSplitViewController {
    // MARK: NSSplitViewDelegate

    override func splitView(_: NSSplitView, effectiveRect _: NSRect, forDrawnRect _: NSRect, ofDividerAt _: Int) -> NSRect {
        .zero
    }
}
