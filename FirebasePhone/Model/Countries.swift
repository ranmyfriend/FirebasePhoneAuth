//
//  Countries.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation

struct Countries: Decodable {
    let countries: [Country]
}

extension Countries {
    var sections: [String] {
        return Array(metaData.keys).sorted(by: <)
    }
    var metaData: [String: [Country]] {
        return Dictionary(grouping: countries, by: {
            guard let char = $0.name.first else {return "Unknown"}
            return String(char)
        })
    }
}
