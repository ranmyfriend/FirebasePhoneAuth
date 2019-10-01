//
//  CountryCodeListDataSource.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 01/10/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation
import UIKit

class CountryCodeListDataSource: NSObject {
    var countryListViewModel: CountryListViewModel
    var isCountryAvailable: ((Bool)->(Void)) = {_ in }
    var didSelectCounty: ((CountryViewModel)->Void) = {_ in }
    init(countryListViewModel: CountryListViewModel) {
        self.countryListViewModel = countryListViewModel
    }
}

// MARK:- UITableViewDelegate,UITableViewDataSource
extension CountryCodeListDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = countryListViewModel.sections.count
        isCountryAvailable(count > 0 ? false : true)
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryListViewModel.numberOfRowsInSection(section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return countryListViewModel.sections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countryListViewModel.titleForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryCodeListCell = tableView.dequeueReusableCell(
            withIdentifier: CountryCodeListCell.reuseIdentifier, for: indexPath) as? CountryCodeListCell
            else { fatalError("Use CountryCodeListCell") }
        if let country = countryListViewModel.countryOnRowIndexPath(indexPath) {
            cell.feedCountry(info: country)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let country = self.countryListViewModel.countryOnRowIndexPath(indexPath) else{return}
        didSelectCounty(country)
    }
    
}
