//
//  WeatherTableViewCell.swift
//  ii tenki
//
//  Created by G4B0 CU4DR05_C4RD3N4S on 2019/06/20.
//  Copyright © 2019 G4B0 CU4DR05_C4RD3N4S. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
