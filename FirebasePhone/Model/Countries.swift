//
//  Countries.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation

class Countries {
    var sections:[String] = []
    var list:[Country] = []
    var metaData:[String:[Country]] = [:]
    
    convenience init(countries:[Country]) {
        self.init()
        countries.forEach({ (country) in
            if let firstChar = country.name?.characters.first?.description {
                if metaData[firstChar] == nil {
                    metaData[firstChar] = [country]
                }else {
                    var appended = metaData[firstChar]
                    appended?.append(country)
                    metaData[firstChar] = appended
                }
                if self.sections.contains(firstChar) == false {
                    self.sections.append(firstChar)
                }
                self.list.append(country)
            }
        })
    }
}

