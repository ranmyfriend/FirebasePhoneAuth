//
//  CountrySelectionTableViewCell.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit

class CountrySelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public class func reuseIdentifier()->String {
        return "CountrySelectionTableViewCell"
    }
    
    public func feedCountry(info:FPCountryModel) {
        self.nameLabel.text = info.displayNameNoE164Cc
        self.codeLabel.text = info.e164Cc
        self.flagLabel.text = info.flag
    }
}
