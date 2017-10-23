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
    var verificationID:String?
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
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }else {
                    debugPrint("Verified successfully")
                    //Once you have verified your phone number kill the firebase session.
                    try? Auth.auth().signOut()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
