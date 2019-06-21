//
//  DetailInteractor.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/21.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DetailInteractor: PresenterToInteractorDetailProtocol {
    
    var presenter: InteractorToPresenterDetailProtocol?
    
    func fetchImage(url: String, imageView: UIImageView) {
        Alamofire.request(url).responseData { (response:DataResponse<Data>) in
            if response.error == nil {
                if let data = response.data {
                    imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
