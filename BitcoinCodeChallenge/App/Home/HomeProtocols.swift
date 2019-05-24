//
//  HomePresenterProtocol.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCities()
    func showWeatherController(navigationController:UINavigationController,weather:HomeModel)
    func handleLocation(completition:@escaping(_ res:Bool)->())

}

protocol PresenterToViewProtocol: class{
    func showHome(homeArray:Array<HomeModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> HomeViewController
    func pushToWeatherController(navigationConroller:UINavigationController, weather:HomeModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchCities(completition:@escaping(_ res:Bool)->())
    func handleLocation(completition:@escaping(_ res:Bool)->())
}

protocol InteractorToPresenterProtocol: class {
    func homeFetchedSuccess(homeModelArray:Array<HomeModel>)
    func homeFetchFailed()
}
