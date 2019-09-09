//
//  ViewController.swift
//  ConcurrencyLabProj
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var countries = [Countries]()
    var pictures = [UIImage]() {
        didSet {
            DispatchQueue.main.async {
                 self.tableOutlet.reloadData()
            }
        }
    }
    var searchString: String? = nil {
        didSet {
            self.tableOutlet.reloadData()
        }
    }
    var countrySearchResults: [Countries] {
        get {
            guard let _ = searchString else {
                return countries
            }
            guard searchString != "" else {
                return countries
            }
            
            let results = countries.filter( {$0.name.lowercased().contains(searchString!.lowercased())})
            
           return results
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchOutlet.resignFirstResponder()
        searchString = searchOutlet.text
    }
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    @IBOutlet weak var tableOutlet: UITableView!
    
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrySearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableOutlet.dequeueReusableCell(withIdentifier: "country") as? CountryTableViewCell {
            switch countrySearchResults[indexPath.row].capital {
            case "":
                cell.capitalLabel.text = ""
            default:
                cell.capitalLabel.text = "Capital: \(countrySearchResults[indexPath.row].capital)"
            }
            cell.nameLabel.text = countrySearchResults[indexPath.row].name
            cell.populationLabel.text = "Population: \(countrySearchResults[indexPath.row].population)"
//            cell.flagOutlet.image = pictures[indexPath.row]
        return cell
        }
        return UITableViewCell()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { fatalError()}
        detailVC.country = countrySearchResults[tableOutlet.indexPathForSelectedRow!.row]
    }
    
    private func LoadData() {
        guard let pathToData = Bundle.main.path(forResource: "country", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let countryDataFromJSON = try Countries.getCountryData(from: data)
            countries = countryDataFromJSON
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
    
    func fetchData() {
        NetworkManager.shared.fetchData(urlString: "https://restcountries.eu/rest/v2/name/united") { (result) in
            switch result {
            case .failure(let error):
                error
            case .success(let data):
                self.countries = data
            }
            
            for i in self.countries {
                ImageHelper.shared.fetchImage(urlString: i.flag) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        if let image = image {
                            self.pictures.append(image)
                        }
                    }
                })
            }

        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchOutlet.delegate = self
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
 //      LoadData()
        fetchData()
        tableOutlet.rowHeight = 200
        
    }


}

