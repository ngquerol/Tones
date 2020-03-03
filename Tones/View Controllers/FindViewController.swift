//
//  FindViewController.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 28/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

// TODO:
//   - search category names
//   - (use pills for search type? (name, category))
//   - use searchTemplate menu to auto-complete suggestions
//   - introduce `datasource bearing` protocol to decouple ColorsViewController ?

import AppKit

class FindViewController: NSViewController {
    // MARK: IBOutlets

    @IBOutlet var searchField: NSSearchField! {
        didSet {
            searchField.delegate = self
        }
    }
    
    // MARK: Properties

    var originalColors: [Color] = []

    private var colorsViewController: ColorsViewController? {
        presentingViewController as? ColorsViewController
    }

    // MARK: IBActions

    @IBAction func userDidTypeInSearchField(_ sender: NSSearchField) {
        guard !sender.stringValue.isEmpty else { return }

        let results = originalColors.filter { color in
            color.name.range(
                of: sender.stringValue,
                options: [.caseInsensitive, .diacriticInsensitive],
                range: color.name.startIndex ..< color.name.endIndex,
                locale: .autoupdatingCurrent
            ) != nil
        }

        colorsViewController?.dataSource.colors = results
        colorsViewController?.collectionView.reloadData()
    }

    @IBAction func findColor(_: Any) { /* noop */ }

    // MARK: View lifecycle
    
    override func viewDidAppear() {
        view.window?.makeFirstResponder(self)
    }
    
    override func viewWillDisappear() {
        view.window?.makeFirstResponder(colorsViewController)
    }

    // MARK: Methods

    override func becomeFirstResponder() -> Bool {
        view.window?.makeFirstResponder(searchField) ?? false
    }

    override func cancelOperation(_: Any?) {
        presentingViewController?.dismiss(self)
    }
}

// MARK: - NSSearchFieldDelegate

extension FindViewController: NSSearchFieldDelegate {
    func searchFieldDidEndSearching(_: NSSearchField) {
        colorsViewController?.dataSource.colors = originalColors
        colorsViewController?.collectionView.reloadData()
    }
}
