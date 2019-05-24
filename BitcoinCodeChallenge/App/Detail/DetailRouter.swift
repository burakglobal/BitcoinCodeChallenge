//
//  DetailRouter.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter:DetailPresenterToRouterProtocol{
    
    static func createModule(weather:HomeModel) -> DetailViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        let presenter: DetailPresenterProtocol & DetailInteractorToPresenterProtocol = DetailPresenter()
        let interactor: DetailPresenterToInteractorProtocol = DetailInteractor(weather: weather)
        let router:DetailPresenterToRouterProtocol = DetailRouter()

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
    
    func goBack() {

    }
    
}
