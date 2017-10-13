//
//  CountryCodeListController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit

protocol countryPickerProtocol {
    func didPickCountry(model:Country)
}

class CountryCodeListController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var countryListTableView: UITableView! {
        didSet {
            countryListTableView.delegate = self
            countryListTableView.dataSource = self
            let nib:UINib = UINib.init(nibName: CountryCodeListCell.reuseIdentifier(), bundle: nil)
            self.countryListTableView.register(nib, forCellReuseIdentifier: CountryCodeListCell.reuseIdentifier())
            
            self.countryListTableView.estimatedRowHeight = 70
            self.countryListTableView.rowHeight = UITableViewAutomaticDimension
            self.countryListTableView.keyboardDismissMode = .onDrag
        }
    }
    
    var countries:Countries?
    var filteredCountries:Countries?
    public var delegate:countryPickerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SELECT A COUNTRY"
    }
}

extension CountryCodeListController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    //MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if searchBar.isEmpty() {
            sections = countries?.sections.count ?? 0
        }else {
            sections = filteredCountries?.sections.count ?? 0
        }
        if sections == 0 {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: countryListTableView.bounds.size.width, height: countryListTableView.bounds.size.height))
            noDataLabel.text = "No country available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            countryListTableView.backgroundView  = noDataLabel
        }else {
            countryListTableView.backgroundView = nil
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isEmpty() {
            let key = countries?.sections[section]
            return countries?.metaData[key!]?.count ?? 0
        }else{
            let key = filteredCountries?.sections[section]
            return filteredCountries?.metaData[key!]?.count ?? 0
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchBar.isEmpty() {
            return countries?.sections
        }else{
            return filteredCountries?.sections
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.isEmpty() {
            return countries?.sections[section]
        }else {
            return filteredCountries?.sections[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CountryCodeListCell = tableView.dequeueReusableCell(withIdentifier: CountryCodeListCell.reuseIdentifier(), for: indexPath) as! CountryCodeListCell
        if searchBar.isEmpty() {
            let key = countries?.sections[indexPath.section]
            if let countries = countries?.metaData[key!] {
                let country:Country = countries[indexPath.row]
                cell.feedCountry(info: country)
            }
        }else {
            let key = filteredCountries?.sections[indexPath.section]
            if let countries = filteredCountries?.metaData[key!] {
                let country:Country = countries[indexPath.row]
                cell.feedCountry(info: country)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.isEmpty() {
            let key = countries?.sections[indexPath.section]
            if let countries = countries?.metaData[key!] {
                let country:Country = countries[indexPath.row]
                self.delegate?.didPickCountry(model: country)
            }
        }else {
            let key = filteredCountries?.sections[indexPath.section]
            if let countries = filteredCountries?.metaData[key!] {
                let country:Country = countries[indexPath.row]
                self.delegate?.didPickCountry(model: country)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            countryListTableView.reloadData()
        }else {
            let list = countries?.list.filter { ($0.name?.hasPrefix(searchText))! || ($0.iso2Cc?.hasPrefix(searchText))! || ($0.e164Cc?.hasPrefix(searchText))!}
            filteredCountries = Countries.init(countries: list!)
            countryListTableView.reloadData()
        }
    }
}

extension UISearchBar {
    func isEmpty()->Bool {
        return (text?.isEmpty)!
    }
}

