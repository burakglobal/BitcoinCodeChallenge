//
//  HomeRouter.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter:PresenterToRouterProtocol{
    
    static func createModule() -> HomeViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter: HomePresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        let router:PresenterToRouterProtocol = HomeRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToWeatherController(navigationConroller navigationController:UINavigationController, weather:HomeModel) {
        
        let detail = DetailRouter.createModule(weather:weather)
        navigationController.pushViewController(detail,animated: true)

    }
    
}
