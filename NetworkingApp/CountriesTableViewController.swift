//
//  CountriesTableViewController.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 02.02.2021.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    var countries: [Country] {
        DataManager.shared.countries
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchDataManually(from: NetworkManager.shared.url) { (countryList) in
            let countries = DataManager.shared.getCountries(from: countryList)
            DataManager.shared.countries = countries
            self.tableView.reloadData()
        }
        
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countries.count
    }

    
    override func tableView(    _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let countryName = countryNames[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = self.countries[indexPath.row].country
        cell.contentConfiguration = content
        return cell
    }

}
