//
//  DataManager.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 04.02.2021.
//

import UIKit

class DataManager {
    
    static var shared = DataManager()
    var countryNames: [String] = []
    var countries: [Country] = []
    var regions: [Region] = []
    
    private init() {}
    
    func getCountries(from json: [String: Any]) -> [Country] {
        if self.countries.count > 0 {
            countries.removeAll()
        }
        
        for (country, regions) in json {
            let country = Country(countryName: country, regions: regions)
            self.countries.append(country)
        }
        return countries
    }
}

