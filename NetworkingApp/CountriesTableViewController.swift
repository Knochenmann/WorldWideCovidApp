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
    // MARK: - Private properties
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let regionsVC = segue.destination as! RegionsTableViewController
        regionsVC.country = sender as? Country
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let regionList = countries[indexPath.row].regions else { return }
        if regionList.count > 0 {
            performSegue(withIdentifier: "regions",
                         sender: countries[indexPath.row])
        } else {
            showAlert(title: "", message: "The information on regions is not available for this country.")
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countries.count
    }

    override func tableView(    _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = self.countries[indexPath.row].country
        cell.contentConfiguration = content
        return cell
    }

}

// MARK: - Table View Delegates


