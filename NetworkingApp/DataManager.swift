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
}

