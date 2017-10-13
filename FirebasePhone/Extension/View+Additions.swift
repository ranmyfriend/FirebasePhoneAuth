//
//  View+Additions.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 10/13/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
