//
//  MainPresenter.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/19.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var router: PresenterToRouterProtocol?
    var interactor: PresenterToInteractorProtocol?
    
    func fetchWeather() {
        interactor?.fetchWeatherData()
    }
    
    func showDetailForSelectedDay(navigationController: UINavigationController, list: [List], searchType: weatherSearchType) {
        router?.pushToDetailScreen(navigationController: navigationController, list: list, searchType: searchType)
    }
    
    func fetchImage(url: String,imageView: UIImageView)  {
        interactor?.fetchImage(url: url, imageView: imageView)
    }
    
}

extension MainPresenter: InteractorToPresenterProtocol {
    
    func weatherFechedSuccess(weatherArray: Array<MainEntity>) {
        view?.showWeather(weatherArray: weatherArray)
    }
    
    func weatherFetchFailed() {
        view?.showError()
    }
}
