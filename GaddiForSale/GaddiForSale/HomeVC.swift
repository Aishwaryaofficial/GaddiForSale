 //
//  HomeVC.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
 
class HomeVC: UIViewController {
    
    let sectionHeader = Xib(name: "ItemCatagories", id: "ItemCatagoriesID")
    let tableCell = Xib(name: "ItemTableViewCell", id: "ItemTableViewCellID")
    let collectionCell = Xib(name: "ItemCollectionViewCell", id: "ItemCollectionViewCellID")
    let fullImageVC = Xib(name: "FullImageVC", id: "FullImageID")
    
    // MARK: @Outlet
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    // DATASOURCE
    
    var hiddenCellsArray : [IndexPath] = [] // array for storeing IndexPath of collection view cell
    var favoriteArray : [[IndexPath]] = []  // array for storeing IndexPath of favorite button superview
    var hideSection : [Int] = []            // array for storeing IndexPath of selected section
   var picturesData : [[[ImageInfo]]] = []     // array for storeing ImageInfo

    
   // var car : [String] = ["BMW","MARUTI","HYUNDAI","FORD", "VOLKSWAGEN"]

  
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets =  false
        
        // setting table view delegate and datasource
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate =  self
        
        // setting up UINib for tableCell , sectionHeader
        
        let listNib = UINib(nibName: tableCell.name, bundle: nil)
        tableViewOutlet.register(listNib, forCellReuseIdentifier: tableCell.id)

        let categoryNib = UINib(nibName: sectionHeader.name, bundle: nil)
        tableViewOutlet.register(categoryNib , forHeaderFooterViewReuseIdentifier: sectionHeader.id)
        
        getImage()
        
     
    }
    
    
}


// MARK: extension HomeVC: UITableViewDataSource, UITableViewDelegate
 //  Table View Delegate and Datasource Methods

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hideSection.contains(section)
        {
            return 0
        } else {
            return picturesData[section].count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: tableCell.id, for: indexPath) as? ItemTableViewCell else { fatalError("Cell Not Found") }
        
        if (hiddenCellsArray.contains(indexPath)){
            cell.hideButton.isSelected = true
            }
            else
            {
            cell.hideButton.isSelected = false
            }
        
        // Initialization code
        
        // setting Collection view delegate and datasource
        
        cell.collectionViewOutlet.dataSource = self
        cell.collectionViewOutlet.delegate = self
        
        let itemNib = UINib(nibName: collectionCell.name, bundle: nil)
        cell.collectionViewOutlet.register(itemNib, forCellWithReuseIdentifier: collectionCell.id)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 120)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .horizontal
        cell.collectionViewOutlet.collectionViewLayout = flowLayout
        
         //  hideButton Action
        
        cell.hideButton.addTarget(self, action: #selector(onHideButton(btn:)), for: .touchUpInside)
       // cell.itemName.text = car[indexPath.section]
        
        // giveing index to tableIndexPath
        
        cell.tableIndexPath = indexPath
        
            return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if hiddenCellsArray.contains(indexPath){
            
             return 40
            
        } else {
            
          return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableViewOutlet.dequeueReusableHeaderFooterView(withIdentifier: sectionHeader.id) as? ItemCatagories
        
        header?.hideButton.addTarget(self, action: #selector(ontabhideSectionBtn(btn:)), for: .touchUpInside)
        
        header?.hideButton.tag = section
        if hideSection.contains(section)
        {
            header?.hideButton.isSelected = true
        }
        else
        {
            header?.hideButton.isSelected = false
        }
       
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return picturesData.count
    }

}
 
 // MARK: extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate
  // Collection  View Delegate and Datasource Methods
 
 extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  picturesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.id, for: indexPath) as?   ItemCollectionViewCell
 
        //  heartButton Action
        
        itemCell?.likeBtn.addTarget(self, action: #selector(ontablikeBtn(btn:)), for: .touchUpInside)
        
        // loading images from PicturesData previewURL
        
        guard let tableCell = collectionView.getTableViewCell as? ItemTableViewCell else { fatalError("cell not found")}
        if picturesData.isEmpty{
            print("no data")
        }else {
        
            if let url = URL(string: picturesData[(tableCell.tableIndexPath?.section)!][(tableCell.tableIndexPath?.row)!][indexPath.row].previewURL) {
                   itemCell?.itemImage.af_setImage(withURL : url)
            }
        }
         return itemCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // navigationController instantiate
        
        let imageShow = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: fullImageVC.id) as! FullImageVC
        
        
        let tablecell = collectionView.getTableViewCell as! ItemTableViewCell
        
        // loading image url from PicturesData to fullImageVC url
        
        let imageData = picturesData[(tablecell.tableIndexPath?.section)!][(tablecell.tableIndexPath?.row)!][indexPath.row]
  
      imageShow.url = URL(string: imageData.webformatURL)
        
        
        self.navigationController?.pushViewController(imageShow, animated: true)
        
    }
    
    // MARK: PRIVATE FUNCTION
    
    func  ontablikeBtn(btn: UIButton){
        
        guard  let tableViewCell = btn.getTableViewCell as? ItemTableViewCell else { return }
        let tableCellIndexPath = tableViewOutlet.indexPath(for: tableViewCell)
        guard  let collectionCell = btn.getCollectionViewCell as? ItemCollectionViewCell else { return }
        let collectionCellIndexPath = tableViewCell.collectionViewOutlet.indexPath(for: collectionCell)
       
        if btn.isSelected {
            favoriteArray = favoriteArray.filter({ (indices : [IndexPath]) -> Bool in
                return indices != [tableCellIndexPath! , collectionCellIndexPath!]
            })
            btn.isSelected = false
            
        } else {
            
            self.favoriteArray.append([tableCellIndexPath! , collectionCellIndexPath!])
            btn.isSelected = true
            
        }
        
        print(favoriteArray)
    }

    func onHideButton (btn: UIButton) {
        
        guard let tableViewCell = btn.getTableViewCell as? ItemTableViewCell else { return }  // getting tableViewCell
        
        let tableCellIndexPath = tableViewOutlet.indexPath(for: tableViewCell)!                // getting tableCellIndexPath
        
        if btn.isSelected {
            
            hiddenCellsArray.remove(at: hiddenCellsArray.index(of: tableCellIndexPath)!)
            btn.isSelected = false
            
        } else {
            hiddenCellsArray.append(tableCellIndexPath)
            btn.isSelected = true
            
        }
        
        // reloading table view cell
        tableViewOutlet.reloadRows(at: [tableCellIndexPath], with: .fade)
        
    }
    
    func ontabhideSectionBtn(btn:UIButton)  {
        
        if btn.isSelected{
                hideSection = hideSection.filter({ (section) -> Bool in
                return section != btn.tag
            })
             btn.isSelected = false
        }
        else{
                hideSection.append(btn.tag)
                btn.isSelected = true
            }
        self.tableViewOutlet.reloadSections([btn.tag], with: .fade)
    }
    
    func getImage(){
        
        var count = 1
        //  fetchDataFromPixabay
        
        for _ in 0...3
        {
            picturesData.append([])
            for index in 0...4
            {
        
        Webservices().fetchDataFromPixabay(withQuery: "bmw",
                                           page: count ,
                                           success: { (images : [ImageInfo]) in
                                            
        if images.count == 0 {
        let alert = UIAlertController(title: "Alert", message: "Not Found", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
                                            
            self.picturesData[index].append(images)
           self.tableViewOutlet.reloadData()
                                            
        }) { (error : Error) in
            
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
                    }
            count = count + 1

        }} }
