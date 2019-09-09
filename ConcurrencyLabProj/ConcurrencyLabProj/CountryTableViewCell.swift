//
//  CountryTableViewCell.swift
//  ConcurrencyLabProj
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var flagOutlet: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
