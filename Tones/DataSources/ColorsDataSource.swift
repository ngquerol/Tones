//
//  ColorsDataSource.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 28/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorsDataSource: NSObject {
    // MARK: Properties

    var colors: [Color]

    // MARK: Initializers

    init(colors: [Color]) {
        self.colors = colors
    }
}

// MARK: - NSCollectionViewDataSource

extension ColorsDataSource: NSCollectionViewDataSource {
    func numberOfSections(in _: NSCollectionView) -> Int {
        colors.mapUnique(from: \.category).count
    }

    func collectionView(_: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories = colors.mapUnique(from: \.category)
        return colors.count(where: \.category, equals: categories[section])
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: ColorCollectionViewItem.identifier, for: indexPath)

        guard let collectionViewItem = item as? ColorCollectionViewItem else { return item }

        let category = colors.mapUnique(from: \.category)[indexPath.section],
            categoryColors = colors.filter { $0.category == category },
            color = categoryColors[indexPath.item]

        collectionViewItem.colorView.representedColor = color.value
        collectionViewItem.colorLabel.stringValue = color.name

        return collectionViewItem
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(
            ofKind: kind,
            withIdentifier: SectionHeaderView.identifier,
            for: indexPath
        )

        guard let sectionHeaderView = view as? SectionHeaderView else { return view }

        let category = colors.mapUnique(from: \.category)[indexPath.section],
            categoryColors = colors.filter { $0.category == category }

        sectionHeaderView.sectionTitleLabel.stringValue = category.description
        sectionHeaderView.sectionItemCountLabel.stringValue = "\(categoryColors.count) color(s)"

        return sectionHeaderView
    }
}

// MARK: - Sequence.uniquing(from:) & Sequence.count(where:equals:)

private extension Sequence {
    func mapUnique<T: Hashable>(from keyPath: KeyPath<Element, T>) -> [T] {
        var elements: [T: Bool] = [:]
        return map { $0[keyPath: keyPath] }
            .filter { elements.updateValue(true, forKey: $0) == .none }
    }

    func count<T: Equatable>(where keyPath: KeyPath<Element, T>, equals value: T) -> Int {
        filter { $0[keyPath: keyPath] == value }.count
    }
}
