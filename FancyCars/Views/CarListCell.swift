//
//  CarListCell.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import UIKit

class CarListCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carMake: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var carAvailibility: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var cellViewModel:CarListCellViewModel? {
        didSet {
            if let cellViewModel = cellViewModel {
                configureCell(cellViewModel: cellViewModel)
            }
        }
    }
    
    private func configureCell(cellViewModel: CarListCellViewModel) {
        if let url = URL(string: cellViewModel.carImageUrl) {
            //Download image on background thread
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    //Get main thread to update UI
                    DispatchQueue.main.async {
                        self.carImage.image = UIImage(data: data)
                    }
                }
            }
        }
        carName.text = cellViewModel.carName
        carMake.text = cellViewModel.carMake
        carModel.text = cellViewModel.carModel
        carYear.text = cellViewModel.carYear
        carAvailibility.text = cellViewModel.carAvailibility.rawValue
        
        if cellViewModel.carAvailibility == .InDealership {
            buyButton.isHidden = false
        } else {
            buyButton.isHidden = true
        }
    }
        
}
