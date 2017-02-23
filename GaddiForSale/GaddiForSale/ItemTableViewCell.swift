//
//  ListCell.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var hideButton: UIButton!
    
    // variable
    
    var tableIndexPath : IndexPath?
    
    // MARK: LIFE CYCLE OF TABLE VIEW CELL
    
    override func awakeFromNib() {
        super.awakeFromNib()
       }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // reloadData of collectionViewOutlet
        
        itemName.text = " "
        collectionViewOutlet.reloadData()
        
        
    }
}
