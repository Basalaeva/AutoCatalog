//
//  console.swift
//  AutoCatalog
//
//  Created by Kate on 02/04/2019.
//  Copyright © 2019 Kate. All rights reserved.
//

import Foundation
class Console {
    var carsStoreage = CarsStorage()
    func menu() {
        while true {
            print(
                
            """
            Список команд:
            list - вывести на экран список автомобилей
            delete - удалить автомобиль из списка
            create - создать автомобиль
            edit - добавить автомобиль
            exit - завершить программу

            """
            )
            let userSelect = readLine() ?? ""
            switch true {
            case userSelect.uppercased().contains("LIST"):
                self.printCarList()
            case userSelect.uppercased().contains("DELETE"):
                self.deleteCar()
            case userSelect.uppercased().contains("CREATE"):
                self.addCar()
            case userSelect.uppercased().contains("EDIT"):
                self.editCar()
            case userSelect.uppercased().contains("EXIT"):
                return
            default:
                print("Неизвестная команда")
            }
        }
    }
    
    func printCarList() {
        var printStringNumber = 0
        let cars = carsStoreage.getCarList()
        var printString = ""
        for car in cars {
            printString = "\(printStringNumber) - "
            for property in Car.Property.allValues {
                printString.append("\(property): \(car[property]) ")
            }
            print(printString)
            printStringNumber += 1
        }
    }
    
    func deleteCar() {
        let cars = carsStoreage.getCarList()
        print("Введите номер автомобиля, который хотите удалить")
        self.printCarList()
        while true {
            if let carNumber = Int(readLine() ?? ""),
                carNumber < cars.count,
                carNumber >= 0 {
                if carsStoreage.remove(car: cars[carNumber]) {
                    print("Операция выполнена")
                }
                else {
                    print("Не удалось выполнить операцию")
                }
                break
            }
            print("Неверная команда")
        }
    }
    
    func addCar() {
        let car = Car()
        for property in Car.Property.allValues {
            print("Введите \(property.rawValue)")
            car[property] = readLine() ?? ""
        }
        if carsStoreage.append(car: car) {
            print("Операция выполнена")
        }
        else {
            print("Не удалось выполнить операцию")
        }
        
    }
    
    func editCar() {
        let cars = carsStoreage.getCarList()
        let newCar = Car()
        print("Введите номер автомобиль, свойства которого хотите изменить")
        self.printCarList()
        carSelect: while true {
            if let carNumber = Int(readLine() ?? ""),
                carNumber < cars.count,
                carNumber >= 0 {
                print("Введите номер свойства, которое хотите изменить")
                var iterator = 0
                for property in Car.Property.allValues {
                    print("\(iterator) - \(property.rawValue)")
                    newCar[property] = cars[carNumber][property] //копируем свойсва из старого автомобиля в новый
                    iterator += 1
                }
                propertySelect: while true {
                    
                    if let propertyNumber = Int(readLine() ?? ""),
                        propertyNumber < Car.Property.allValues.count,
                        propertyNumber >= 0 {
                        print("Введите \(Car.Property.allValues[propertyNumber])")
                        newCar[Car.Property.allValues[propertyNumber]] = readLine() ?? ""
                        break propertySelect
                    }
                    print("Неверная команда")
                }
                if carsStoreage.modify(oldCar: cars[carNumber], newCar: newCar) {
                    print("Операция выполнена")
                }
                else {
                    print("Не удалось выполнить операцию")
                }
                break carSelect
            }
            print("Неверная команда")
        }
    }
}
