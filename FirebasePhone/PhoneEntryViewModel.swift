//
//  PhoneEntryViewModel.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 25/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation
import Firebase

struct PhoneEntryViewModel {
    private(set) var countries: Countries!
    var localeCountry: Country?
    var countryCodeTxt = Dynamic<String>("")
    
    init() {
        do {
            self.countries = try JSONReader.countries()
        } catch let e {
            debugPrint("Error:\(e.localizedDescription)")
        }
        self.setDeviceLocale()
    }
}

extension PhoneEntryViewModel {
    
    mutating func setDeviceLocale() {
        guard let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String else {
            fatalError("No Locale found!")
        }
        self.localeCountry = countries.countries.filter {($0.iso2_cc == countryCode)}.first
        self.countryCodeTxt.value = (localeCountry?.iso2_cc)! + " " + "(+" + (localeCountry?.e164_cc)! + ")"
    }
    
    func send(code: String, completionHandler: @escaping (Result<String,Error>) -> Void) {
        let phoneNumber = "+" + (localeCountry?.e164_cc)! + code
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                return completionHandler(.failure(error))
            }
            guard let verificationID = verificationID else { return }
            completionHandler(.success(verificationID))
        }
    }
}
