//
//  CarListViewModel.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import Foundation

class CarListViewModel {
    var updateUIClosure: ()->() = {}
    private var cars:[CarDto] = []
    
    //MARK: Fetch data methods
    func fetchCarList() {
        serviceAPI.sharedInstance.fetchCarList(successHandler: { (cars) in
            self.cars = cars
            self.fetchCarsAvailability()
        }, errorHandler: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    private func fetchCarsAvailability() {
        //Fetch car availibility value for individual car
        for index in 0..<cars.count {
            serviceAPI.sharedInstance.fetchCarAvailibility(carId: cars[index].carId, successHandler: { (carAvailibility) in
                let carAvailibilityValue = CarAvailability(rawValue: carAvailibility) ?? .Unknown
                self.cars[index].carAvailibility = carAvailibilityValue
            }, errorHandler: { (errorMessage) in
                self.cars[index].carAvailibility = .Unknown
                print(errorMessage)
            })
        }
        self.updateUIClosure()
    }
    
    //MARK: Sort Functions
    func sortCarsByName() {
        cars = cars.sorted { (initial, next) -> Bool in
            return initial.name.compare(next.name) == .orderedAscending
        }
    }
    
    func sortCardsByAvailibility() {
        cars = cars.sorted { (initial, next) -> Bool in
            return initial.carAvailibility!.sortIndex < next.carAvailibility!.sortIndex
        }
    }
    
    //MARK: Table View Functions
    func numberOfRowsInSection() -> Int {
        return cars.count
    }
    
    func cellViewModelAtIndexPath(indexPath: IndexPath) -> CarListCellViewModel {
        let car : CarDto = cars[indexPath.row]
        
        let cellViewModel = CarListCellViewModel()
        cellViewModel.carImageUrl = car.imageUrl
        cellViewModel.carMake = car.make
        cellViewModel.carModel = car.model
        cellViewModel.carName = car.name
        cellViewModel.carYear = car.year
        cellViewModel.carAvailibility = car.carAvailibility ?? .Unknown
        
        return cellViewModel
    }
}
