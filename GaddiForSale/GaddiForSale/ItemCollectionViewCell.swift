//
//  ItemCollectionCellCollectionViewCell.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    //MARK:  @IBOutlet

    
    @IBOutlet weak var itemlabel: UILabel!

    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
    // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            
        itemImage.image = nil
        itemlabel.text = " "
            
        }
}
