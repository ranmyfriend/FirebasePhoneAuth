//
//  Extension+UITextField.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 25/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func applyBorderProperties() {
        textColor = UIColor.systemBlue
        layer.borderWidth = 1.5
        layer.borderColor = textColor?.cgColor
        layer.cornerRadius = 3.0
    }
}


