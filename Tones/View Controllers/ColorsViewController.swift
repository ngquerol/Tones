//
//  ColorsViewController.swift
//  Tones
//
//  Created by Nicolas Gaulard-Querol on 26/02/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import AppKit

class ColorsViewController: NSViewController {
    // MARK: IBOutlets

    @IBOutlet var collectionView: NSCollectionView! {
        didSet {
            collectionView.dataSource = dataSource
        }
    }

    // MARK: Actions
    
    @IBAction func findColor(_ NSMenuItem: Any) {
        performSegue(withIdentifier: FindColorsSegue.identifier, sender: self)
    }

    // MARK: Properties

    var dataSource = ColorsDataSource(colors: Color.all)
    
    // MARK: Segue

    override func prepare(for segue: NSStoryboardSegue, sender _: Any?) {
        guard
            segue.identifier == FindColorsSegue.identifier,
            let colorsViewController = segue.sourceController as? ColorsViewController,
            let findViewController = segue.destinationController as? FindViewController
        else {
            return
        }
        
        findViewController.originalColors = colorsViewController.dataSource.colors
    }
}
