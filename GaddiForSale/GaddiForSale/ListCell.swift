//
//  ListCell.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: OUTLET
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    // MARK: LIFE CYCLE OF TABLE VIEW CELL
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
        
        let itemNib = UINib(nibName: "ItemCollectionCellCollectionViewCell", bundle: nil)
        collectionViewOutlet.register(itemNib, forCellWithReuseIdentifier: "itemCollectionCellCollectionViewCellID")

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 120)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .horizontal
        
        collectionViewOutlet.collectionViewLayout = flowLayout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: PRIVATE FUNCTION
    
    func configureWithData(_ data : [String:String]) {
        
       // itemName.text = data["title"]
      
    }
}

extension ListCell : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionCellCollectionViewCellID", for: indexPath) as?   ItemCollectionCellCollectionViewCell
            return itemCell!
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
    
}
