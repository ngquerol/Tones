//
//  ColorsDataSource.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 28/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorsDataSource: NSObject, NSCollectionViewDataSource {
    func numberOfSections(in _: NSCollectionView) -> Int {
        Colors.Category.allCases.count
    }

    func collectionView(_: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        Colors[section].colors.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: ColorCollectionViewItem.identifier, for: indexPath)

        guard let collectionViewItem = item as? ColorCollectionViewItem else { return item }

        let color = Colors[indexPath]

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

        let category = Colors[indexPath.section]

        sectionHeaderView.sectionTitleLabel.stringValue = category.description
        sectionHeaderView.sectionItemCountLabel.stringValue = "\(category.colors.count) color(s)"

        return sectionHeaderView
    }
}
