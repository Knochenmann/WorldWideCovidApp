//
//  NetworkManager.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 02.02.2021.
//
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let url = "https://covid-api.mmediagroup.fr/v1/cases"
    var json: [String: Any] = [:]
    
    private init() {}

    func getCountryList(from JSON: [String: Any]) -> [String] {
        var countryList: [String] = []
        for (key, _) in JSON {
            countryList.append(key)
        }
        return countryList
    }
    
    func getRegionList(from JSON: [String: Any]) -> [Region] {
        var regionList: [Region] = []
        for (key, value) in JSON {
            let region = Region(regionName: key, value: value)
            regionList.append(region)
        }
        return regionList
    }
    
    public func fetchDataManually(from urlString: String, with complition: @escaping ([String: Any]) -> Void) {
        
        guard let jsonurl = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: jsonurl) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }

            do {
                let countryListJSON = try JSONSerialization.jsonObject(with: data, options: []) // вручную
                let countryList = countryListJSON as? [String: Any] ?? [:]
                self.json = countryList
                DispatchQueue.main.async {
                    complition(countryList)
                }
//                let countryDict = countryList["Russia"] as? [String: Any] ?? [:]
//
//                for (key, value) in countryDict {
//                    let region = Region(regionName: key, value: value)
//                    DataManager.shared.regions.append(region)
//                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}






//    static func fetchData() -> Data {
//
//        // создаем ссылку с типом String:
//        let url = "https://covid-api.mmediagroup.fr/v1/cases"
//
//        // преобразуем string в URL:
//        guard let jsonurl = URL(string: url) else { return }
//
//        // реализуем URL-сессию по заданной ссылке:
//        URLSession.shared.dataTask(with: jsonurl) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let response = response {
//                print(response)
//            }
//            guard let data = data else { return }
//
//            do {
//                let countryList = try JSONDecoder().decode(CountryList.self, from: data)
//                print(countryList)
//
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
    
//    static func fetchDataManually() {
//
//        // создаем ссылку с типом String:
//        let url = "https://covid-api.mmediagroup.fr/v1/cases"
//
//        // преобразуем string в URL:
//        guard let jsonurl = URL(string: url) else { return }
//
//        // реализуем URL-сессию по заданной ссылке:
//        URLSession.shared.dataTask(with: jsonurl) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let response = response {
//                print(response)
//            }
//            guard let data = data else { return }
//
//            print("DATA: \(data)")
//
//            do {
//                let countryList = try JSONDecoder().decode(CountryList.self, from: data)
////                guard let countryList = countryListJSON as? [String: Any] else { return }
//                print(countryList)
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
