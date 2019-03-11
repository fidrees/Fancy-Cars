//
//  DataModel.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import Foundation

enum CarAvailability: String {
    case OutOfStock = "Out of Stock"
    case Unavailable = "Unavailable"
    case InDealership = "In Dealership"
    case Unknown = "Unknown"
}

extension CarAvailability {
    var sortIndex : Int {
        switch self {
        case .InDealership:
            return 0
        case .OutOfStock:
            return 1
        case .Unavailable:
            return 2
        case .Unknown:
            return 3
        }
    }
}

struct CarDto: Decodable {
    var carId: Int
    var imageUrl: String
    var make: String
    var model: String
    var name: String
    var year: String
    var carAvailibility: CarAvailability?
    
    init(carId: Int, imageUrl: String, make: String, model: String, name: String, year: String) {
        self.carId = carId
        self.imageUrl = imageUrl
        self.make = make
        self.model = model
        self.name = name
        self.year = year
    }
    
    enum CodingKeys: String, CodingKey {
        case carId = "id", imageUrl = "img", make, model, name, year
    }
}
