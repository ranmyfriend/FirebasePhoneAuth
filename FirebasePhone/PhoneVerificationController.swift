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
    var verificationID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Enter your 6 digit code"
    }
   
    @IBAction func didTapVerifyFourDigitCode(_ sender: Any) {
        if let verificationCode = verificationCodeTextField.text {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }else {
                    debugPrint("Verified successfully")
                    //Once you have verified your phone number kill the firebase session.
                    try? Auth.auth().signOut()
                }
            }
        }
    }
    
}
