//
//  CountryListViewModel.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 27/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation

class CountryListViewModel {
    let countries: [CountryViewModel]
    var filteredCountries: [CountryViewModel] = []
    
    var searchTxt = Dynamic<String>("")
    var isSearchEnabled = Dynamic<Bool>(false)
    
    init(countries: [CountryViewModel]) {
        self.countries = countries
    }
}

//MARK: Datasource methods
extension CountryListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        let key = sections[section]
        return metaData[key]?.count ?? 0
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return sections[section]
    }
    
    func countryOnRowIndexPath(_ indexPath: IndexPath) -> CountryViewModel? {
        let sectionKey = sections[indexPath.section]
        let countries = metaData[sectionKey]
        return countries?[indexPath.row]
    }
    
}

//MARK: custom getters & setters
extension CountryListViewModel {
    
    fileprivate var countryArray: [CountryViewModel] {
        return isSearchEnabled.value ? filteredCountries : countries
    }
    
    var sections: [String] {
        return Array(metaData.keys).sorted(by: <)
    }
    
    fileprivate var metaData: [String: [CountryViewModel]] {
        return Dictionary(grouping: countryArray, by: {String($0.country.name.first!)})
    }
    
}

//MARK: Plain old functions
extension CountryListViewModel {
    
    func updateSearchState() {
        if !searchTxt.value.isEmpty {
            let list = countries.filter {
                ($0.country.name.hasPrefix(searchTxt.value)) ||
                    ($0.country.iso2cc.hasPrefix(searchTxt.value)) ||
                    ($0.country.e164cc.hasPrefix(searchTxt.value))
            }
            self.filteredCountries = list
            isSearchEnabled.value = true
        }else {
            isSearchEnabled.value = false
        }
    }
}
