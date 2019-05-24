//
//  DetailPresenterProtocol.swift
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: class{
    
    var view: DetailPresenterToViewProtocol? {get set}
    var interactor: DetailPresenterToInteractorProtocol? {get set}
    var router: DetailPresenterToRouterProtocol? {get set}
    func showDetails()
}

protocol DetailPresenterToViewProtocol: class{
    func showDetail(weather:HomeModel)
    func showError()
}

protocol DetailPresenterToRouterProtocol: class {
    static func createModule(weather:HomeModel)-> DetailViewController
    func goBack()
}

protocol DetailPresenterToInteractorProtocol: class {
    var presenter:DetailInteractorToPresenterProtocol? {get set}
    func showDetails()
}

protocol DetailInteractorToPresenterProtocol: class {
    func DetailFetchedSuccess(weather:HomeModel)
    func DetailFetchFailed()
}
