//
//  PhoneEntryController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit

class PhoneEntryController: UIViewController {
    
    //MARK: iVars
    @IBOutlet weak var sendCodeButton: UIButton! {
        didSet {
            sendCodeButton.applyBorderProperties()
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField! {
        didSet {
            countryCodeTextField.applyBorderProperties()
        }
    }
    
    lazy var titleView: UIView = {
        let label = UILabel()
        label.text = "Entry Scene\n( Watch debug console for the Errors )"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.systemPink
        label.sizeToFit()
        return label
    }()
    
    var viewModel = PhoneEntryViewModel()
    
    //MARK: Overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleView
        view.addTapToDismissKeyboard()
        
        self.viewModelSetup()
    }
    
    private func viewModelSetup() {
        self.viewModel.countryCodeTxt.bindAndFire({ (code) in
            self.countryCodeTextField.text = code
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneTextField.becomeFirstResponder()
        addAdditionalNavigationItemChanges()
    }
    
    //MARK: Private functions
    private func addAdditionalNavigationItemChanges() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: Button Actions
    @IBAction func sendCode(_ sender: Any) {
        guard let phone = phoneTextField.text else {
            debugPrint("Enter your Phone number!")
            return
        }
        view.endEditing(true)
        self.viewModel.send(code: phone) { (result) in
            switch result {
                case .success(let vID):
                    let verifyScene = PhoneVerificationController()
                    verifyScene.verificationID = vID
                    self.navigationController?.pushViewController(verifyScene, animated: true)
                case .failure(let e):
                    debugPrint(e.localizedDescription)
            }
        }
    }
    
    @IBAction func showCountryCode(_ sender: Any) {
        if let countries = viewModel.countries {
            let listScene = CountryCodeListController(countries: countries.countries)
            listScene.delegate = self
            navigationController?.pushViewController(listScene, animated: true)
        } else {
            debugPrint("Countries not yet loaded or failed :(")
        }
    }
    
}

//MARK: Extension | CountryPickerProtocol
extension PhoneEntryController: countryPickerProtocol {
    func didPickCountry(model: Country) {
        viewModel.localeCountry = model
        countryCodeTextField.text = model.iso2_cc + " " + "(+" + model.e164_cc + ")"
    }
}
