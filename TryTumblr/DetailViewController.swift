//
//  DetailViewController.swift
//  TryTumblr
//
//  Created by Kumawat, Diwakar on 3/31/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // detailLabel.text = ("You tapped the cell at index \(index!)")
        imageView.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
