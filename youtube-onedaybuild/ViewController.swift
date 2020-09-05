//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Kassie Green on 9/4/20.
//  Copyright © 2020 Nicki J. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    // trying again
    var model = Model ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
           
        model.getVideos()
        
    }


}

