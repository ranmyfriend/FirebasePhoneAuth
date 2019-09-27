//
//  CountryCodeListCell.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit

class CountryCodeListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "CountryCodeListCell"
    }
    public func feedCountry(info: CountryViewModel) {
        self.nameLabel.text = info.country.display_name_no_e164_cc
        self.codeLabel.text = info.country.e164_cc
        self.flagLabel.text = info.country.flag
    }
}
