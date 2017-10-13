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
    
    public class func reuseIdentifier()->String {
        return "CountryCodeListCell"
    }
    public func feedCountry(info:Country) {
        self.nameLabel.text = info.displayNameNoE164Cc
        self.codeLabel.text = info.e164Cc
        self.flagLabel.text = info.flag
    }
}
