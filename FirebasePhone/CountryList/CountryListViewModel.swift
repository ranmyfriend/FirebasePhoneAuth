//
//  CountryListViewModel.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 27/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation

class CountryListViewModel {
    let countries:[CountryViewModel]
    var filteredCountries: [CountryViewModel] = []
    
    var searchTxt = Dynamic<String>("")
    var isSearchEnabled = Dynamic<Bool>(false)
    
    init(countries:[CountryViewModel]) {
        self.countries = countries
    }
}

//TableView Delegate & Datasource methods
extension CountryListViewModel {
    func numberOfSections() -> Int {
        if isSearchEnabled.value {
            return fsections.count
        }else {
            return sections.count
        }
    }
    
    func tableView(numberOfRowsInSection section: Int) -> Int{
        if isSearchEnabled.value {
            let key = fsections[section]
            return fmetaData[key]?.count ?? 0
        }else {
            let key = sections[section]
            return metaData[key]?.count ?? 0
        }
    }
    
    func sectionIndexTitles() -> [String]? {
        if isSearchEnabled.value {
            return fsections
        }else {
            return sections
        }
    }
    
    func tableView(titleForHeaderInSection section: Int) -> String? {
        if isSearchEnabled.value {
            return fsections[section]
        }else {
            return sections[section]
        }
    }
    func tableView(cellForRowAt indexPath: IndexPath) -> CountryViewModel? {
        if isSearchEnabled.value {
            let sectionKey = fsections[indexPath.section]
            let countries = fmetaData[sectionKey]
            return countries?[indexPath.row]
        }else {
            let sectionKey = sections[indexPath.section]
            let countries = metaData[sectionKey]
            return countries?[indexPath.row]
        }
    }
    
    func tableView(didSelectRowAt indexPath: IndexPath) -> CountryViewModel? {
        return tableView(cellForRowAt: indexPath)
    }
    
}

// custom getters & setters
extension CountryListViewModel {
    var sections: [String] {
        return Array(metaData.keys).sorted(by: <)
    }
    var metaData: [String: [CountryViewModel]] {
        return Dictionary(grouping: countries, by:{String($0.country.name.first!)})
    }
}

extension CountryListViewModel {
    var fsections: [String] {
        return Array(fmetaData.keys).sorted(by: <)
    }
    var fmetaData: [String: [CountryViewModel]] {
        return Dictionary(grouping: filteredCountries, by:{String($0.country.name.first!)})
    }
}


//plain old functions
extension CountryListViewModel {
    
    func updateSearchState() {
        if !searchTxt.value.isEmpty {
            let list = countries.filter {
                ($0.country.name.hasPrefix(searchTxt.value)) ||
                    ($0.country.iso2_cc.hasPrefix(searchTxt.value)) ||
                    ($0.country.e164_cc.hasPrefix(searchTxt.value))
            }
            self.filteredCountries = list
            isSearchEnabled.value = true
        }else {
            isSearchEnabled.value = false
        }
    }
}
