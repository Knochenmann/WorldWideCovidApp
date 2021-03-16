//
//  CountriesTableViewController.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 02.02.2021.
//

import UIKit

class CountriesTableViewController: UITableViewController {
   
    @IBOutlet var searchBarOutlet: UISearchBar!
    
    var countries: [Country] = []
    
    var firstCharacters: Set<Character> = []
    var sortedCountries: [[Country]] = []
    var searchCountries: [Country] = []
    var isSearching = false
    var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        fetchData()
        
    }
    
    // MARK: - Public properties
    
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: - Private properties
    
    private func UISetup() {
        
        spinner = activityIndicator(inView: view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(fetchData))
    }
    
    private func activityIndicator(inView: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    @objc private func fetchData() {
        NetworkManager.shared.fetchDataManually(from: NetworkManager.shared.url) { (countryList) in
            self.countries = DataManager.shared.getCountries(from: countryList).sorted()
            self.sortCountries(countries: self.countries)
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    private func sortCountries(countries: [Country]) {
        
        for country in countries {
            if let character = country.country?.first {
                firstCharacters.insert(character)
            }
        }
        
        for character in firstCharacters.sorted() {
            var array: [Country] = []
            for country in countries {
                if country.country?.first == character {
                    array.append(country)
                }
            }
            sortedCountries.append(array.sorted())
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let regionsVC = segue.destination as! RegionsTableViewController
        regionsVC.country = sender as? Country
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var countriesInSection: [Country] = []
        if isSearching {
            countriesInSection = searchCountries
        } else {
        countriesInSection = sortedCountries[indexPath.section]
        }
        
        guard let regionList = countriesInSection[indexPath.row].regions else { return }
        if regionList.count > 0 {
            performSegue(withIdentifier: "regions",
                         sender: countriesInSection[indexPath.row])
        } else {
            showAlert(title: "", message: "The information on regions is not available for this country.")
        }
    }
 
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return sortedCountries.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return ""
        } else {
        guard let title = sortedCountries[section].first?.country?.first else { return ""}
        return String(title)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchCountries.count
        } else {
        return sortedCountries[section].count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountriesTableViewCell
        
        var countriesInSection: [Country] = []
        if isSearching {
            countriesInSection = searchCountries
        } else {
        countriesInSection = sortedCountries[indexPath.section]
        }
        cell.countryNameLabel.text = countriesInSection[indexPath.row].country
        cell.capitalCityLabel.text = countriesInSection[indexPath.row].capitalCity ?? "Not available"
        cell.continentLabel.text = countriesInSection[indexPath.row].continent  ?? "Not available"
        
        if countriesInSection[indexPath.row].regions?.count != 0 {
            cell.detailedRegionalInfoLabel.text = "Regional info: available"
            cell.detailedRegionalInfoLabel.font = .boldSystemFont(ofSize: 13)
        } else {
            cell.detailedRegionalInfoLabel.text = "Regional info: not available"
            cell.detailedRegionalInfoLabel.font = .systemFont(ofSize: 13)
        }
        
        cell.confirmedLabel.text = "Confirmed: \(countriesInSection[indexPath.row].confirmed ?? 0) ca."
        cell.recoveredLabel.text = "Recovered: \(countriesInSection[indexPath.row].recovered ?? 0) ca."
        cell.deathsLabel.text = "Deaths: \(countriesInSection[indexPath.row].deaths ?? 0) ca."
        
        if let population = countriesInSection[indexPath.row].population {
            if population <= 1000000 {
                cell.populationLabel.text = "Population: \(((population / 1000))) tsd."
            } else {
                cell.populationLabel.text = "Population: \(((Double(population) / 10000).rounded() / 100)) m."
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
}

// MARK: - UISearchBarDelegate

extension CountriesTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarOutlet.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            searchCountries = countries.filter { $0.country?.hasPrefix(searchText) ?? false }
            isSearching = true
            tableView.reloadData()
        } else {
            isSearching = false
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.endEditing(true)
        isSearching = false
        tableView.reloadData()
    }
}

