//
//  DetailViewController.swift
//  ConcurrencyLabProj
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var country: Countries!
    
    @IBOutlet weak var flagImageOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()
    }
    
    private func loadData() {
        nameLabel.text = country.name
        if country.capital == "" {
            capitalLabel.text = ""
        } else {
            capitalLabel.text = "Capital: \(country.capital)"
        }
        populationLabel.text = "Population: \(country.population)"
    }
}



