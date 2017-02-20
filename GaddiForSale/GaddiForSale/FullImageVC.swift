//
//  iteMVC.swift
//  GaddiForSale
//
//  Created by Appinventiv on 17/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class FullImageVC: UIViewController {

    //MARK: PROPERTY
    
    var image: UIImage!
     
    // MARK: @IBOutlet
    
    @IBOutlet weak var imagedisplay: UIImageView!
       
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
       imagedisplay.image = image
    }
}
