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
    
    // MARK:- iVars
    lazy var countryListTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.delegate = datasource
        tableView.dataSource = datasource
        let nib: UINib = UINib(nibName: CountryCodeListCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CountryCodeListCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    let countryListViewModel: CountryListViewModel
    let datasource: CountryCodeListDataSource
    
    public weak var delegate: countryPickerProtocol?
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        return searchController
    }()
    
    lazy var noDataLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "🤷‍♂️ No country available"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.center = countryListTableView.center
        label.sizeToFit()
        return label
    }()
    
    // MARK:- Overriden functions
    init(countries: [Country]) {
        let countries = countries.map({ CountryViewModel(country: $0) })
        self.countryListViewModel = CountryListViewModel(countries: countries)
        self.datasource = CountryCodeListDataSource(countryListViewModel: self.countryListViewModel)
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
        viewModelSetup()
        
        dataSourceSetup()
    }
    
    private func viewModelSetup() {
        self.countryListViewModel.isSearchEnabled.bindAndFire { _ in
            self.countryListTableView.reloadData()
        }
    }
    
    private func dataSourceSetup() {
        self.datasource.isCountryAvailable = { enabled in
            if !enabled {
                self.countryListTableView.backgroundView = nil
            }else {
                self.countryListTableView.backgroundView = self.noDataLabel
            }
        }
        
        self.datasource.didSelectCounty = { country in
            self.delegate?.didPickCountry(model: country.country)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK:- Private functions
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

// MARK:- Extension | UISearchResultsUpdating
extension CountryCodeListController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.countryListViewModel.searchTxt.value = searchController.searchBar.text!
        self.countryListViewModel.updateSearchState()
    }
    
}
