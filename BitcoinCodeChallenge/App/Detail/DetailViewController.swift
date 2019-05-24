//
//  DetailViewController.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var city: UILabel!
    
    weak var presentor:DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.largeTitle()
        presentor?.showDetails()
    }

    deinit {
        print("DetailViewController deinitilized")
    }
}

extension DetailViewController:DetailPresenterToViewProtocol{

    func showDetail(weather:HomeModel) {
        self.city.text = weather.cityName
        self.tempLabel.text = weather.tempString
        self.icon.image = weather.weatherIcon
    }
    
    func showError() {
        self.presentAlert("Ooops", message: "Error loading the weather data")
    }

}

