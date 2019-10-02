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
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vId, verificationCode: code)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let err = error {
                completionHandler(.failure(err))
            }else {
                try? Auth.auth().signOut()
                completionHandler(.success(true))
            }
        }
    }
}
