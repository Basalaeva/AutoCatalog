//
//  Car.swift
//  AutoCatalog
//
//  Created by Kate on 02/04/2019.
//  Copyright © 2019 Kate. All rights reserved.
//

import Foundation

class Car: Codable {
    
    enum Property: String {
        case year
        case model
        case manufacturer
        case `class`
        case bodyType
        
        static let allValues: [Property] = [.year, .bodyType, .class, .manufacturer, .model]
    }
    
    subscript(property: Property) -> String {
        get {
            if let index = Property.allValues.firstIndex(of: property), index < data.count {
                return data[index]
            }
            return ""
        }
        set {
            if let index = Property.allValues.firstIndex(of: property) {
                while data.count <= index  {
                    data.append("")
                }
                data[index] = newValue
            }
        }
    }
    
    internal var data: [String] = []
    
    
    init() {
        data = [String](repeating: "", count: Property.allValues.count)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        /*let decodableData = try container.decode([String : String].self)
         for (key, value) in decodableData {
         data[Property(rawValue: key)!] = value
         }
         */
        data = try container.decode([String].self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        /*var result: [String: String] = [:]
         for (key, value) in data {
         result[key.rawValue] = value
         }
         */
        try container.encode(data)
        
    }
}
