//
//  FPCountryCodeHelper.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation
import SwiftyJSON

class FPCountryCodeHelper: NSObject {
    
    public var countryList:[String:[FPCountryModel]] = [:]
    public var titles:[String] = []
    public var countries:[FPCountryModel] = []
    
    public func manipulateData(with countries:[FPCountryModel]) {
        countries.forEach({ (country) in
            if let prefix = country.name?.characters.first?.description {
                if countryList[prefix] == nil {
                    countryList[prefix] = [country]
                }else {
                    var appended = countryList[prefix]
                    appended?.append(country)
                    countryList[prefix] = appended
                }
                if self.titles.contains(prefix) == false {
                    self.titles.append(prefix)
                }
                self.countries.append(country)
            }
        })
    }
    
    public func rkInitialize() {
        let url = Bundle.main.url(forResource: "country-codes", withExtension: "json")
        let data = NSData(contentsOf: url!)
        do {
            let wrapped = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [[String:Any]]
            let countryModels = wrapped.map({ FPCountryModel.init(object: $0) })
           self.manipulateData(with: countryModels)
        } catch {
            // Handle Error
            debugPrint(error)
        }
    }
}


