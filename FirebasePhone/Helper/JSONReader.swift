//
//  JSONReader.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 9/2/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation

struct JSONReader {
    static func countries() -> Countries? {
        let url = Bundle.main.url(forResource: "country-codes", withExtension: "json")
        let data = try! Data.init(contentsOf: url!)
        do {
            return try JSONDecoder().decode(Countries.self, from: data)
        } catch {
            // Handle Error
            debugPrint(error)
            return nil
        }
    }
}
