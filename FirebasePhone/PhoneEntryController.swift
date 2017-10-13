//
//  PhoneEntryController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase

class PhoneEntryController: UIViewController,countryPickerProtocol {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField! {
        didSet {
            countryCodeTextField.textColor = UIView().tintColor
            countryCodeTextField.layer.borderWidth = 1.5
            countryCodeTextField.layer.borderColor = countryCodeTextField.textColor?.cgColor
            countryCodeTextField.layer.cornerRadius = 3.0
            addLocaleCountryCode()
        }
    }
    let countries:Countries = {
        return Countries.init(countries: JSONReader.countries())
    }()
    var localeCountry:Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Entry Scene"
        view.addTapToDismissKeyboard()
    }
    
    //MARK: - Private Functions
    private func addLocaleCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            localeCountry = countries.list.filter {($0.iso2Cc == countryCode)}.first
            countryCodeTextField.text = (localeCountry?.iso2Cc!)! + " " + "(+" + (localeCountry?.e164Cc!)! + ")"
        }
    }
    
    //MARK: - Button Actions
    @IBAction func didTapSendCode(_ sender: Any) {
        if phoneTextField.text?.characters.count == 0 {
            debugPrint("Enter Phone number!")
            return
        }
        let phoneNumber = "+" + (localeCountry?.e164Cc!)! + phoneTextField.text!
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let verificationID = verificationID else { return }
            let verifyScene = PhoneVerificationController()
            verifyScene.verificationID = verificationID
            self.navigationController?.pushViewController(verifyScene, animated: true)
        }
    }
    
    @IBAction func didTapShowCountryCode(_ sender: Any) {
        let listScene = CountryCodeListController()
        listScene.delegate = self
        listScene.countries = countries
        navigationController?.pushViewController(listScene, animated: true)
    }
    
    //MARK: - countryPickerProtocol functions
    func didPickCountry(model: Country) {
        localeCountry = model
        countryCodeTextField.text = model.iso2Cc! + " " + "(+" + model.e164Cc! + ")"
    }
    
}
