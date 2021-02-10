//
//  ViewController.swift
//  NetworkingApp
//
//  Created by Егор Костюхин on 01.02.2021.
//

import UIKit

class ViewController: UIViewController {

    var countries = DataManager.shared.countries
    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkManager.fetchDataManually()        
    }

}
