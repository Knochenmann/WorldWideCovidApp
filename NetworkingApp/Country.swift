//
//  Country.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 02.02.2021.
//

struct Country: Decodable {
    
    var country: String?
    let capitalCity: String?
    let population: Int?
    let continent: String?
    let confirmed: Int?
    let recovered: Int?
    let deaths: Int?
    let updated: String?
    
    init(value: [String: Any], countryName: String) {
        country = countryName
        capitalCity = value["capital_city"] as? String
        population = value["population"] as? Int
        continent = value["continent"] as? String
        confirmed = value["confirmed"] as? Int
        recovered = value["recovered"] as? Int
        deaths = value["deaths"] as? Int
        updated = value["updated"] as? String
    }
    
}

struct RegionList: Decodable {
    
    let All: Country?
    
}

struct CountryList: Decodable {

    let Russia: RegionList?
    let Afghanistan: RegionList?
    
}

struct Region: Decodable {
    
    let country: String?
    let capitalCity: String?
    let region: String?
    let population: Int?
    let continent: String?
    let confirmed: Int?
    let recovered: Int?
    let deaths: Int?
    let updated: String?
    
    init(regionName: String, value: Any) {
        let regionDict = value as? [String: Any] ?? [:]
        country = regionDict["country"] as? String
        capitalCity = regionDict["capital_city"] as? String
        region = regionName
        population = regionDict["population"] as? Int
        continent = regionDict["continent"] as? String
        confirmed = regionDict["confirmed"] as? Int
        recovered = regionDict["recovered"] as? Int
        deaths = regionDict["deaths"] as? Int
        updated = regionDict["updated"] as? String
    }
}
