//
//  LoginPresenter.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter:HomePresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?

    func handleLocation(completition:@escaping(_ res:Bool)->()) {

        interactor?.handleLocation(completition: { (res) in
            completition(true)
        })
    }

    func startFetchingCities() {
        interactor?.fetchCities(completition: { (res) in
            
        })
    }
    
    func showWeatherController(navigationController: UINavigationController, weather:HomeModel) {
        router?.pushToWeatherController(navigationConroller:navigationController, weather:weather)
    }

}

extension HomePresenter: InteractorToPresenterProtocol{
    
    func homeFetchedSuccess(homeModelArray: Array<HomeModel>) {
        view?.showHome(homeArray: homeModelArray)
    }
    
    func homeFetchFailed() {
        view?.showError()
    }
    
    
}
