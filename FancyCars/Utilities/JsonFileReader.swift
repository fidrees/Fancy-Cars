//
//  JsonFileReader.swift
//  FancyCars
//
//  Created by Fahad Idrees on 2019-03-10.
//  Copyright © 2019 Fahad Idrees. All rights reserved.
//

import Foundation

// JsonReader
///
/// A helper class to load json .
final class JsonReader {
    
    /// Returns a dictionary from JSON file
    ///
    /// - Parameters:
    ///   - jsonFileName: Name of json file
    static func load(jsonFileName fileName: String) -> Data? {
        do {
            let currentBundle = Bundle(for: self)
            guard let file = currentBundle.url(forResource: fileName, withExtension: "json") else {
                return nil
            }
            
            let data = try Data(contentsOf: file)
            //let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            return data
        } catch {
            return nil
        }
    }
}
