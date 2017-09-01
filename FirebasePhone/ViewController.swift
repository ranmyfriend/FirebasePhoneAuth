//
//  ViewController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,countryPickerProtocol {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    var verificationID:String?
    var countries:Countries = Countries()
    var localeCountry:Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        countries.loadCountries()
        addLocaleCountryCode()
    }
    
    //MARK: - Private Functions
    private func addLocaleCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            localeCountry = countries.list.filter {($0.iso2Cc == countryCode)}.first
            countryCodeTextField.text = (localeCountry?.iso2Cc!)! + " " + "(+" + (localeCountry?.e164Cc!)! + ")"
        }
    }

    //MARK: - Button Actions
    @IBAction func didTapCall(_ sender: Any) {
        let phoneNumber = "+" + (localeCountry?.e164Cc!)! + phoneTextField.text!
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let verificationID = verificationID else { return }
            self.verificationID = verificationID
        }
    }

    @IBAction func didTapAuth(_ sender: Any) {
        if let verificationCode = phoneTextField.text {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else {
                    debugPrint("Authenticated successfully")
                }
            }   
        }
    }
    
    @IBAction func didTapShowCountryCode(_ sender: Any) {
        let listScene = CountryCodeListController()
        listScene.delegate = self
        listScene.countries = countries
        self.navigationController?.pushViewController(listScene, animated: true)
    }
    
    //MARK: - countryPickerProtocol functions
    func didPickCountry(model: Country) {
        self.countryCodeTextField.text = model.iso2Cc! + " " + "(+" + model.e164Cc! + ")"
    }
    
}
