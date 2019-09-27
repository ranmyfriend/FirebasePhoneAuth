//
//  PhoneVerifyViewModel.swift
//  FirebasePhone
//
//  Created by Kumar, Ranjith B. (623-Extern) on 27/09/19.
//  Copyright © 2019 Ranjith Kumar. All rights reserved.
//

import Foundation
import Firebase

struct PhoneVerifyViewModel {
    
    func verifyDigitCode(code: String, vId: String, completionHandler: @escaping (Result<Bool,Error>)->Void) {
        let phoneAuthProvider = PhoneAuthProvider.provider()
        let credential = phoneAuthProvider.credential(withVerificationID: vId, verificationCode: code)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                completionHandler(.failure(error))
            }else {
                debugPrint("Verified successfully")
                //Once you have verified your phone number kill the firebase session.
                try? Auth.auth().signOut()
                completionHandler(.success(true))
            }
        }
    }
}
