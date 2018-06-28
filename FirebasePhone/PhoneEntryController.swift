//
//  PhoneEntryController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase

class PhoneEntryController: UIViewController {

    //MARK: - iVars
    @IBOutlet weak var sendCodeButton: UIButton!{
        didSet {
            sendCodeButton.applyBorderProperties()
        }
    }
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
    let countries: Countries = Countries(countries: JSONReader.countries())
    var localeCountry: Country?

    //MARK: - Overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleView()
        view.addTapToDismissKeyboard()
        phoneTextField.text = "9704963170"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneTextField.becomeFirstResponder()
        addAdditionalNavigationItemChanges()
    }
    
    //MARK: - Private functions
    private func addAdditionalNavigationItemChanges() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    }
    private func titleView() -> UILabel {
        let label = UILabel()
        label.text = "Entry Scene\n( Watch debug console for the Errors )"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = view.tintColor
        label.sizeToFit()
        return label
    }
    
    private func addLocaleCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            localeCountry = countries.list.filter {($0.iso2Cc == countryCode)}.first
            countryCodeTextField.text = (localeCountry?.iso2Cc!)! + " " + "(+" + (localeCountry?.e164Cc!)! + ")"
        }
    }
    
    //MARK: - Button Actions
    @IBAction func sendCode(_ sender: Any) {
        if phoneTextField.text?.count == 0 {
            debugPrint("Enter Phone number!")
            return
        }
        view.endEditing(true)
        let phoneNumber = "+" + (localeCountry?.e164Cc!)! + phoneTextField.text!
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
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
    
    @IBAction func showCountryCode(_ sender: Any) {
        let listScene = CountryCodeListController()
        listScene.delegate = self
        listScene.countries = countries
        navigationController?.pushViewController(listScene, animated: true)
    }
    
}


//MARK: - Extension| CountryPickerProtocol
extension PhoneEntryController: countryPickerProtocol {
    func didPickCountry(model: Country) {
        localeCountry = model
        countryCodeTextField.text = model.iso2Cc! + " " + "(+" + model.e164Cc! + ")"
    }
}

extension UIButton {
    func applyBorderProperties() {
        layer.borderWidth = 1.5
        layer.borderColor = tintColor?.cgColor
        layer.cornerRadius = 3.0
    }
}
