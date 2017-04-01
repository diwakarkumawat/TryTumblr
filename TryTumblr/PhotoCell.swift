//
//  PhotoCell.swift
//  TryTumblr
//
//  Created by Kumawat, Diwakar on 3/31/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
