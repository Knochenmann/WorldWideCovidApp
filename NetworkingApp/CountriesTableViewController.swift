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
//            DataManager.shared.countryNames = NetworkManager.shared.getCountryList(from: countryList).sorted()
//            self.tableView.reloadData()
            
            // создаем экземпляры стран
            for (country, regions) in NetworkManager.shared.json {
                guard let regions = regions as? [String: Any] else { return }
                guard let totalInfo = regions["All"] as? [String: Any] else { return }
                let country = Country(value: totalInfo, countryName: country)
                DataManager.shared.countries.append(country)
                self.tableView.reloadData()
                
//                for region in regions {
//                    let region = Country(value: regions, countryName: country)
//                    DataManager.shared.countries.append(region)
//                }
//                guard let info = regions as? [String: Any] else { return }
                
                print(DataManager.shared.countries)
            }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countries[indexPath.row].country
    }

}
