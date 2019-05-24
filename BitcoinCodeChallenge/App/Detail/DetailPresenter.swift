//
//  LoginPresenter.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

class DetailPresenter:DetailPresenterProtocol {
    
    weak var view: DetailPresenterToViewProtocol?
    
    var interactor: DetailPresenterToInteractorProtocol?
    
    weak var router: DetailPresenterToRouterProtocol?

    func showDetails() {
        interactor?.showDetails()
    }


}

extension DetailPresenter: DetailInteractorToPresenterProtocol{
    func DetailFetchedSuccess(weather: HomeModel) {
        view?.showDetail(weather: weather)
    }
    
    func DetailFetchFailed() {
        view?.showError()
    }
    
    
}
