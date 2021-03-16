//
//  Country.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 02.02.2021.
//

struct Country: Decodable, Comparable {

    var country: String?
    var capitalCity: String?
    var regions: [Region]?
    var population: Int?
    var continent: String?
    var confirmed: Int?
    var recovered: Int?
    var deaths: Int?
    var updated: String?
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.country! == rhs.country!
    }
    
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.country! < rhs.country!
    }

    init(countryName: String, regions: Any) {
            
            let regionsDict = regions as? [String: Any] ?? [:]
            let total = regionsDict["All"] as? [String: Any] ?? [:] //the way to total country info
            
            country = countryName
            capitalCity = total["capital_city"] as? String
            population = total["population"] as? Int
            continent = total["continent"] as? String
            confirmed = total["confirmed"] as? Int
            recovered = total["recovered"] as? Int
            deaths = total["deaths"] as? Int
            updated = total["updated"] as? String
            self.regions = []
        
            // obtaining an array with regions for each country
            regionsDict.forEach { (region, info) in
                if region != "All" {
                    let regionInfo = info as? [String: Any] ?? [:]
                    let region = Region(regionInfo: regionInfo, regionName: region)
                    self.regions?.append(region)
                }
            }
        }
    }


