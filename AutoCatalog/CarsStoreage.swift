//
//  CarsStoreage.swift
//  AutoCatalog
//
//  Created by Kate on 02/04/2019.
//  Copyright © 2019 Kate. All rights reserved.
//

import Foundation

class CarsStorage {
    private var cars: [Car] = []
    
    private lazy var fileURL: URL = {
        let directoryURL = FileManager.default.homeDirectoryForCurrentUser
        return directoryURL.appendingPathComponent("cars.data")
    }()
    
    init(){
        load()
    }
    
    
    func getCarList() -> [Car] {
        return self.cars
    }
    
    func remove(car: Car) -> Bool {
        assert(cars.contains(where: {car === $0}))
        if let index = cars.firstIndex(where: {car === $0}) {
            cars.remove(at: index)
        }
        return save()
    }
    
    func append(car: Car) -> Bool {
        assert(!cars.contains(where: {car === $0}))
        cars.append(car)
        return save()
    }
    
    func modify(oldCar: Car, newCar: Car) -> Bool {
        assert(cars.contains(where: {oldCar === $0}))
        if let index = cars.firstIndex(where: {oldCar === $0}){
            cars[index] = newCar
            return save()
        }
        return false
    }
    
    private func save() -> Bool {
        if let data: Data = try? JSONEncoder().encode(cars) {
            return nil != (try? data.write(to: fileURL))
        }
        return false
    }
    
    @discardableResult
    private func load() -> Bool {
        do {
            let data = try Data(contentsOf: fileURL)
            cars = try JSONDecoder().decode([Car].self, from: data)
            return true
        } catch {
            return false
        }
    }
}
