//
//  Extension+UIButton.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 25/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func applyBorderProperties() {
        layer.borderWidth = 1.5
        layer.borderColor = tintColor?.cgColor
        layer.cornerRadius = 3.0
    }
}
