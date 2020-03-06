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

private typealias ColorPredicate = (Color) -> Bool

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

        colorsViewController?.dataSource.colors = filterColors(from: sender.stringValue)
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

    private func filterColors(from searchTerm: String) -> [Color] {
        let predicates: [ColorPredicate] = [
            { searchTerm.matchesApproximately($0.name) },
            { searchTerm.matchesApproximately($0.category.description) },
        ]

        // TODO: short-circuit predicates evaluation
        return originalColors.filter { color in predicates.reduce(false) { $0 || $1(color) } }
    }
}

// MARK: - String.matchesApproximately(_:)

private extension String {
    func matchesApproximately(_ string: String) -> Bool {
        string.range(
            of: self,
            options: [.caseInsensitive, .diacriticInsensitive],
            range: string.startIndex ..< string.endIndex,
            locale: .autoupdatingCurrent
        ) != nil
    }
}

// MARK: - NSSearchFieldDelegate

extension FindViewController: NSSearchFieldDelegate {
    func searchFieldDidEndSearching(_: NSSearchField) {
        colorsViewController?.dataSource.colors = originalColors
        colorsViewController?.collectionView.reloadData()
    }
}
