//
//  SignIn.swift
//  FireBase_SDK
//
//  Created by TFE-002 on 06/02/24.
//

import Foundation
import Firebase
import FirebaseAuth
import PromiseKit
//import

public class SFirebaseSDK {
    
    public enum AuthenticationResult {
            case success(User)
            case failure(Error)
        }
    public enum PhoneVerificationResult {
            case success(String)
            case failure(Error)
        }
    
    public static func login(email: String, password: String, completion: @escaping (AuthenticationResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    
    public static func signUp(email: String, password: String, completion: @escaping (AuthenticationResult) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
//                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    
    static func sendVerificationCode(to phoneNumber: String, completion: @escaping (PhoneVerificationResult) -> Void) {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(.failure(error))
                } else if let verificationID = verificationID {
                    completion(.success(verificationID))
                }
            }
        }
        
        static func verifyOTP(with verificationID: String, otp: String, completion: @escaping (AuthenticationResult) -> Void) {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                }
            }
        }
    
    
}
