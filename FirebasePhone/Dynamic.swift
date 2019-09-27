//
//  Dynamic.swift
//  SimpleMVVM
//
//  Created by Kumar, Ranjith B. (623-Extern) on 24/09/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
