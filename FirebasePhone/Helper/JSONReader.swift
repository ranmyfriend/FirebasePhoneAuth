//
//  JSONReader.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 9/2/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case noValidURL
    case noValidJSON
}

struct JSONReader {
    static func countries() throws -> Countries {
        guard let url = Bundle.main.url(forResource: "country-codes.json", withExtension: nil) else {
            throw JSONError.noValidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Countries.self, from: data)
        } catch {
            throw JSONError.noValidJSON
        }
    }
}
