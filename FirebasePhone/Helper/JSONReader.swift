//
//  JSONReader.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 9/2/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation

struct JSONReader {
    static func countries()->[Country] {
        let url = Bundle.main.url(forResource: "country-codes", withExtension: "json")
        let data = try! Data.init(contentsOf: url!)
        do {
            let wrapped = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            return wrapped.map({ Country.init(object: $0) })
        } catch {
            // Handle Error
            debugPrint(error)
            return []
        }
    }
}
