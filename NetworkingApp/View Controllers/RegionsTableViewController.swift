//
//  RegionsTableViewController.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 10.02.2021.
//

import UIKit

class RegionsTableViewController: UITableViewController {

    var country: Country!
    var regions: [Region]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regions = country.regions?.sorted(by: {$0 < $1})
        tableView.rowHeight = 110
        title = "\(country.country ?? "")"
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        regions.count
    }

    override func tableView(    _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionsTableViewCell
        
        cell.regionNameLabel.text = regions[indexPath.row].regionName ?? "Unknown"
        cell.confirmedCasesLabel.text = "Confirmed: \(regions[indexPath.row].confirmed ?? 0) ca."
        cell.recoveredCasesLabel.text = "Recovered: \(regions[indexPath.row].recovered ?? 0) ca."
        cell.deathsLabel.text = "Deaths: \(regions[indexPath.row].deaths ?? 0) ca."
        return cell
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }

}
