//
//  DetailRouter.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/21.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter: PresenterToRouterDetailProtocol {
    
    static var detailStoryboard: UIStoryboard {
        return UIStoryboard(name: "DetailView", bundle: Bundle.main)
    }
    
    static func createModule(data: [List], searchType: weatherSearchType) -> DetailViewController {
        let view = detailStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        var presenter: ViewToPresenterDetailProtocol & InteractorToPresenterDetailProtocol = DetailPresenter()
        var router: PresenterToRouterDetailProtocol = DetailRouter()
        var interactor: PresenterToInteractorDetailProtocol = DetailInteractor()
        
        view.presenter = presenter
        view.lists = data
        view.searchType = searchType
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
