//
//  ServiceAPI.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import Foundation

typealias apiSuccessHandler = (Data?, URLResponse?) -> Void
typealias apiErrorHandler = (String) -> Void

class serviceAPI {
    
    static let sharedInstance = serviceAPI()
    
    func fetchCarList(successHandler: @escaping ([CarDto]) -> Void, errorHandler: @escaping apiErrorHandler) {
        
        let carListJsonFile = "CarList"
        guard let carsData = JsonReader.load(jsonFileName: carListJsonFile) else {
            errorHandler("Unable to fetch data from file")
            return
        }
        do {
            let carsDto = try JSONDecoder().decode(Array<CarDto>.self, from: carsData)
            successHandler(carsDto)
        } catch {
            errorHandler("Unable to parse data")
        }
    }
    
    func fetchCarAvailibility(carId: Int, successHandler: @escaping (String) -> Void, errorHandler: @escaping apiErrorHandler) {
        
        //Not using carId parameter as this is not actual api call, this function will randomly return availibility value
        
        //Randomly returning availibility value
        let number = Int.random(in: 1...3)
        
        if number == 1 {
            successHandler("Out of Stock")
        } else if number == 2 {
            successHandler("Unavailable")
        } else {
            successHandler("In Dealership")
        }
    }
}
