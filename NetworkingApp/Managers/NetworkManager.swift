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
                let countryListJSON = try JSONSerialization.jsonObject(with: data, options: [])
                let countryList = countryListJSON as? [String: Any] ?? [:]
                
                DispatchQueue.main.async {
                    complition(countryList)
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
