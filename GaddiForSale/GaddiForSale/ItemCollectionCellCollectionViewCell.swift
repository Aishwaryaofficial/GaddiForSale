//
//  ItemCollectionCellCollectionViewCell.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ItemCollectionCellCollectionViewCell: UICollectionViewCell {
    
    //MARK:  @IBOutlet

    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
    }
}
