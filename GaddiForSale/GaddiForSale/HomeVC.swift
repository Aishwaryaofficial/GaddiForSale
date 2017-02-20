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
    
    let sectionHeader = xib(name: "ItemCatagories", id: "ItemCatagoriesID")
    let tableCell = xib(name: "ItemTableViewCell", id: "ItemTableViewCellID")
    let collectionCell = xib(name: "ItemCollectionViewCell", id: "ItemCollectionViewCellID")
    let fullImageVC = xib(name: "FullImageVC", id: "FullImageID")
    
    // MARK: @Outlet
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    // DATASOURCE
    
    var hiddenCellsArray: [IndexPath] = []
    var favoriteArray: [[IndexPath]] = []
    var hideSection: [Int] = []
    var dogPicturesData: [ImageInfo] = []
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting table view delegate and datasource
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate =  self
        
        self.automaticallyAdjustsScrollViewInsets =  false
        
        let listNib = UINib(nibName: tableCell.name, bundle: nil)
        tableViewOutlet.register(listNib, forCellReuseIdentifier: tableCell.id)

        let categoryNib = UINib(nibName: sectionHeader.name, bundle: nil)
        tableViewOutlet.register(categoryNib , forHeaderFooterViewReuseIdentifier: sectionHeader.id)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchData(withQuery query: String) {
        
        let URL = "https://pixabay.com/api/"
        
        let parameters = ["key" : "4605957-37b558ec4bd8690ce822e16e7",
                          
                          "q" : query
        ]
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response :DataResponse<Any>) in
                            
                            if let value = response.value as? [String:Any] {
                                
                                let json = JSON(value)
                                
                           //     self.dogPicturesData = json["hits"].array  as? [[String : Any]]
                                
                                
                            } else if let error = response.error {
                                
                                print(error)
                            }
                            
        }
        
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
            return 5
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
            return 4
    }

}
 
 // MARK: extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate
  // Collection  View Delegate and Datasource Methods
 
 extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.id, for: indexPath) as?   ItemCollectionViewCell
        
        //  heartButton Action
        itemCell?.likeBtn.addTarget(self, action: #selector(ontablikeBtn(btn:)), for: .touchUpInside)
        return itemCell!
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let imageShow = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: fullImageVC.id) as! FullImageVC
        guard  let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
        imageShow.image = cell.itemImage.image
        UIView.animate(withDuration: 0.5, animations: {

        self.navigationController?.pushViewController(imageShow, animated: true)
            UIView.setAnimationTransition(.curlUp, for: self.navigationController!.view!, cache: false)
        })
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
        
        guard let tableViewCell = btn.getTableViewCell as? ItemTableViewCell else { return }
        
        let tableCellIndexPath = tableViewOutlet.indexPath(for: tableViewCell)!
        
        if btn.isSelected {
            
            hiddenCellsArray.remove(at: hiddenCellsArray.index(of: tableCellIndexPath)!)
            btn.isSelected = false
            
        } else {
            hiddenCellsArray.append(tableCellIndexPath)
            btn.isSelected = true
            
        }
        
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
    
}
 

 
