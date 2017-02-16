 //
//  HomeViewController.swift
//  GaddiForSale
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: @Outlet
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate =  self
        
        self.automaticallyAdjustsScrollViewInsets =  false
        
        let listNib = UINib(nibName: "ListCell", bundle: nil)
        tableViewOutlet.register(listNib, forCellReuseIdentifier: "listCellID")

        let categoryNib = UINib(nibName: "ItemCatagories", bundle: nil)
        tableViewOutlet.register(categoryNib , forHeaderFooterViewReuseIdentifier: "itemCatagoriesID")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: EXTENSION

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "listCellID", for: indexPath) as? ListCell else { fatalError("Cell Not Found") }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableViewOutlet.dequeueReusableHeaderFooterView(withIdentifier: "itemCatagoriesID") as? ItemCatagories
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 4
    }
    
}
