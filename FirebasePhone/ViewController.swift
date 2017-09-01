//
//  ViewController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,countryPicker {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    var verificationID:String?
    let countryList:FPCountryCodeHelper = FPCountryCodeHelper.init()
    var localeCountry:FPCountryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLocaleCountryCode()
    }
    
    //MARK: - Private Functions
    private func addLocaleCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            countryList.rkInitialize()
            self.localeCountry = countryList.countries.filter {($0.iso2Cc == countryCode)}.first
            self.countryCodeTextField.text = (self.localeCountry?.iso2Cc!)! + " " + "(+" + (self.localeCountry?.e164Cc!)! + ")"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapCall(_ sender: Any) {
        let phoneNumber = "+" + (self.localeCountry?.e164Cc!)! + self.phoneTextField.text!
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let verificationID = verificationID else { return }
            print("verificationID:\(verificationID)")
            self.verificationID = verificationID
        }
    }

    @IBAction func didTapAuth(_ sender: Any) {
        if let verificationCode = self.phoneTextField.text {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else {
                    print("Authenticated successfully")
                }
            }   
        }
    }
    
    @IBAction func didTapShowCountryCode(_ sender: Any) {
        let selectionVC = CountryCodeSelectionViewController()
        selectionVC.delegate = self
        selectionVC.countryList = countryList
        self.navigationController?.pushViewController(selectionVC, animated: true)
    }
    
    func didPickCountry(model: FPCountryModel) {
        self.countryCodeTextField.text = model.iso2Cc! + " " + "(+" + model.e164Cc! + ")"
    }
    
}
