//
//  LoginRegisterVC.swift
//  bon-voyage
//
//  Created by DVKSH on 30.06.22.
//

import UIKit
import FirebaseAuth

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
        dismiss(animated: true)
    }
    
    
    @IBAction func registerClicked(_ sender: Any) {
        
        // Validation
        
        guard let email = registerEmailTxt.text, !email.isEmpty,
        let password = registerPasswordTx.text, !password.isEmpty,
        let confirmPassword = registerPasswordTx.text, !confirmPassword.isEmpty else {
            
            // Present alert
            return
        }
        
        if password != confirmPassword {
            // Present alert
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            defer {
                self.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            self.dismiss(animated: true)

        }
        
    }
}
 
