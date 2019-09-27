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
    
    //MARK: iVars
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
    
    let countryListViewModel: CountryListViewModel
    
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
    
    //MARK: Overriden functions
    init(countries: [Country]) {
        let countries = countries.map({CountryViewModel(country: $0)})
        self.countryListViewModel = CountryListViewModel(countries: countries)
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
    }
    
    private func viewModelSetup() {
        self.countryListViewModel.isSearchEnabled.bindAndFire { _ in
            self.countryListTableView.reloadData()
        }
    }
    
    //MARK: Private functions
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

//MARK: UITableViewDelegate,UITableViewDataSource
extension CountryCodeListController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        let count = countryListViewModel.numberOfSections()
        if count > 0 {
            countryListTableView.backgroundView = nil
        } else {
            countryListTableView.backgroundView = noDataLabel
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryListViewModel.tableView(numberOfRowsInSection: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return countryListViewModel.sectionIndexTitles()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countryListViewModel.tableView(titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryCodeListCell = tableView.dequeueReusableCell(
            withIdentifier: CountryCodeListCell.reuseIdentifier, for: indexPath) as? CountryCodeListCell
            else {fatalError("Use CountryCodeListCell")}
        if let country = countryListViewModel.tableView(cellForRowAt: indexPath) {
            cell.feedCountry(info: country)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let country = self.countryListViewModel.tableView(didSelectRowAt: indexPath) {
            self.delegate?.didPickCountry(model: country.country)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Extension | UISearchResultsUpdating
extension CountryCodeListController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.countryListViewModel.searchTxt.value = searchController.searchBar.text!
        self.countryListViewModel.updateSearchState()
    }
    
}
