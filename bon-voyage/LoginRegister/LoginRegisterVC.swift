//
//  LoginRegisterVC.swift
//  bon-voyage
//
//  Created by DVKSH on 30.06.22.
//

import UIKit
import FirebaseAuth
import FirebaseFunctions
import FirebaseFirestore

class LoginRegisterVC: UIViewController {
    
    @IBOutlet weak var loginEmailTxt: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var registerEmailTxt: UITextField!
    @IBOutlet weak var registerPasswordTx: UITextField!
    @IBOutlet weak var registerConfirmPassTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginBTNClicked(_ sender: Any) {
        guard let email = loginEmailTxt.text, email.isNotEmpty,
              let password = loginPassword.text, password.isNotEmpty else {
            simpleAlert(msg: "Please fill in all required fields.")
            return
        }
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            defer {
                self.activityIndicator.stopAnimating()
            }
            if let error = error {
                self.simpleAlert(msg: error.localizedDescription)
                return
            }
            
            self.dismiss(animated: true)
        }
        
    }
    
    
    @IBAction func registerClicked(_ sender: Any) {
        
        // Validation
        
        guard let email = registerEmailTxt.text, email.isNotEmpty,
              let password = registerPasswordTx.text, password.isNotEmpty,
              let confirmPassword = registerConfirmPassTxt.text, confirmPassword.isNotEmpty else {
            
            // Present alert
            simpleAlert(msg: "Please fill in all required fields.")
            return
        }
        
        if password != confirmPassword {
            simpleAlert(msg: "Passwords do not match")
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            defer {
                self.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(msg: error.localizedDescription)
                return
            }
            
            let log: [String: Any] = [
                "msg": "A new user signed up.",
                "timestamp": Timestamp()
            ]
            
            Firestore.firestore().collection("logs").addDocument(data: log) { error in
                if let error = error {
                    print(error)
                } else {
                    print("Log Successfully Added")
                }
            }
            Functions.functions().httpsCallable("createStripeUser").call(["email": email]) { result, error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    return
                }
                
                guard let userId = Auth.auth().currentUser?.uid else { return }
                
                Firestore.firestore().collection("users").document(userId).getDocument { snapshot, error in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                        return
                    }
                    guard let data = snapshot?.data() else { return }
                    
                    print(data)
                }
                
                self.dismiss(animated: true)
            }
        }
        
    }
}

