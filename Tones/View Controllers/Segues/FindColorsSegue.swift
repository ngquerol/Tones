//
//  SlideInSegue.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 28/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class FindColorsSegue: NSStoryboardSegue {
    static let identifier: NSStoryboardSegue.Identifier = "findColors"

    override var identifier: NSStoryboardSegue.Identifier {
        FindColorsSegue.identifier
    }

    private let animator = SlideInViewControllerPresentationAnimator()

    override func perform() {
        guard
            let sourceController = sourceController as? NSViewController,
            let destinationController = destinationController as? NSViewController
        else {
            return
        }

        sourceController.present(destinationController, animator: animator)
    }
}

private class SlideInViewControllerPresentationAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard
            let containerViewController = fromViewController.parent as? NSSplitViewController
        else {
            return
        }

        containerViewController.insertSplitViewItem(NSSplitViewItem(viewController: viewController), at: 0)
    }

    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard
            let containerViewController = fromViewController.parent as? NSSplitViewController,
            let viewControllerSplitViewItem = containerViewController.splitViewItem(for: viewController)
        else {
            return
        }

        containerViewController.removeSplitViewItem(viewControllerSplitViewItem)
    }
}
