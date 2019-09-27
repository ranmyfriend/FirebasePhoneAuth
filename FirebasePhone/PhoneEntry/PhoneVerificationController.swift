//
//  PhoneVerificationController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 9/2/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase

class PhoneVerificationController: UIViewController {
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton! {
        didSet {
            verifyButton.applyBorderProperties()
        }
    }
    var verificationID:String!
    let viewModel = PhoneVerifyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter your 6 digit code"
        view.addTapToDismissKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verificationCodeTextField.becomeFirstResponder()
    }
    
    @IBAction func didTapVerifyFourDigitCode(_ sender: Any) {
        if verificationCodeTextField.text?.isEmpty == true {
            debugPrint("Enter your verification code!")
            return
        }
        view.endEditing(true)
        if let verificationCode = verificationCodeTextField.text {
            viewModel.verifyDigitCode(code: verificationCode, vId: verificationID) { (result) in
                switch result {
                    case .success(_ ):
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let e):
                        debugPrint(e.localizedDescription)
                }
            }
        }
    }
    
}
