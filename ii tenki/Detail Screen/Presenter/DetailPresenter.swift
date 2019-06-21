//
//  DetailPresenter.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/21.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import UIKit

class DetailPresenter: ViewToPresenterDetailProtocol {
    
    var view: PresenterToViewDetailProtocol?
    var router: PresenterToRouterDetailProtocol?
    var interactor: PresenterToInteractorDetailProtocol?
    
    func fetchImage(url: String, imageView: UIImageView) {
        interactor?.fetchImage(url: url, imageView: imageView)
    }
    
    
}

extension DetailPresenter: InteractorToPresenterDetailProtocol {
    
}
