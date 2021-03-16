//
//  Region.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 16.03.2021.
//

struct Region: Decodable {
    
    var regionName: String?
    var confirmed: Int?
    var recovered: Int?
    var deaths: Int?
    var updated: String?
    
    static func < (lhs: Region, rhs: Region) -> Bool {
        lhs.regionName! < rhs.regionName!
    }
    
    init(regionInfo: [String: Any], regionName: String) {
        self.regionName = regionName
        confirmed = regionInfo["confirmed"] as? Int
        recovered = regionInfo["recovered"] as? Int
        deaths = regionInfo["deaths"] as? Int
        updated = regionInfo["updated"] as? String
    }
}
