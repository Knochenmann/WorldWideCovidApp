//
//  CountriesTableViewCell.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 11.02.2021.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var capitalCityLabel: UILabel!
    @IBOutlet var continentLabel: UILabel!
    @IBOutlet var detailedRegionalInfoLabel: UILabel!
    
    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var deathsLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
