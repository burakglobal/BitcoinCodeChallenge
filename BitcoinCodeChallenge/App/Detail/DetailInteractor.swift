//
//  DetailViewController.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation

class DetailInteractor: DetailPresenterToInteractorProtocol{
    var presenter: DetailInteractorToPresenterProtocol?
    var weather:HomeModel

    init(weather:HomeModel) {
        self.weather = weather
    }

    func showDetails() {
        self.presenter?.DetailFetchedSuccess(weather: self.weather)
    }

}
