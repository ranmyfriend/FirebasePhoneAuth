//
//  CountryCodeListController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit

protocol countryPickerProtocol: class {
    func didPickCountry(model: Country)
}

class CountryCodeListController: UIViewController {
    
    //MARK: - iVars
    lazy var countryListTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        let nib:UINib = UINib(nibName: CountryCodeListCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CountryCodeListCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none

        return tableView
    }()
    
    let countries: Countries
    var filteredCountries: Countries = Countries(countries: [])
    
    public weak var delegate: countryPickerProtocol?
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        return searchController
    }()
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    lazy var noDataLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "🤷‍♂️ No country available"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.center = countryListTableView.center
        label.sizeToFit()
        return label
    }()
    
    //MARK: - Overriden functions
    init(countries: Countries) {
        self.countries = countries
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SELECT A COUNTRY"
        addAdditionalNavigationItemChanges()
        view.addSubview(countryListTableView)
    }
    
    //MARK: - Private functions
    private func addAdditionalNavigationItemChanges() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            // Fallback on earlier versions
        }
    }
    
}

//MARK: - Extension| UITableViewDelegate,UITableViewDataSource
extension CountryCodeListController: UITableViewDelegate,UITableViewDataSource {
    //MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBar.isEmpty() {
            countryListTableView.backgroundView = nil
            return countries.sections.count
        }else {
            if filteredCountries.sections.isEmpty {
                countryListTableView.backgroundView  = noDataLabel
            }else {
                countryListTableView.backgroundView = nil
            }
            return filteredCountries.sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isEmpty() {
            let key = countries.sections[section]
            return countries.metaData[key]?.count ?? 0
        }else{
            let key = filteredCountries.sections[section]
            return filteredCountries.metaData[key]?.count ?? 0
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchBar.isEmpty() {
            return countries.sections
        }else{
            return filteredCountries.sections
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.isEmpty() {
            return countries.sections[section]
        }else {
            return filteredCountries.sections[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryCodeListCell = tableView.dequeueReusableCell(withIdentifier: CountryCodeListCell.reuseIdentifier, for: indexPath) as! CountryCodeListCell
        if searchBar.isEmpty() {
            let sectionKey = countries.sections[indexPath.section]
            if let countries = countries.metaData[sectionKey] {
                let country: Country = countries[indexPath.row]
                cell.feedCountry(info: country)
            }
        }else {
            let sectionKey = filteredCountries.sections[indexPath.section]
            if let countries = filteredCountries.metaData[sectionKey] {
                let country: Country = countries[indexPath.row]
                cell.feedCountry(info: country)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchBar.isEmpty() {
            let sectionKey = countries.sections[indexPath.section]
            if let countries = countries.metaData[sectionKey] {
                let country:Country = countries[indexPath.row]
                self.delegate?.didPickCountry(model: country)
            }
        }else {
            let sectionKey = filteredCountries.sections[indexPath.section]
            if let countries = filteredCountries.metaData[sectionKey] {
                let country:Country = countries[indexPath.row]
                self.delegate?.didPickCountry(model: country)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.searchController.isActive = false
            self?.navigationItem.titleView = nil
            self?.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - Extension | UISearchResultsUpdating
extension CountryCodeListController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
            !searchText.isEmpty {
            let list = countries.countries.filter {
                ($0.name.hasPrefix(searchText)) ||
                ($0.iso2_cc.hasPrefix(searchText)) ||
                ($0.e164_cc.hasPrefix(searchText))
            }
            filteredCountries = Countries(countries: list)
        }
        countryListTableView.reloadData()
    }
    
}

//MARK: - Extension | UISearchBar
extension UISearchBar {
    func isEmpty() -> Bool {
        return (text?.isEmpty)!
    }
}

