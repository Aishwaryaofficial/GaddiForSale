//
//  ItemCollectionCellCollectionViewCell.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    
        //MARK:  @IBOutlet

    @IBOutlet weak var itemLabel: UILabel!

    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  imageView.image = image
        }
    
}
