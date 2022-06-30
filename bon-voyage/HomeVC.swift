//
//  ViewController.swift
//  bon-voyage
//
//  Created by DVKSH on 29.06.22.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginVC = LoginRegisterVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    @IBAction func userIconClecked(_ sender: Any) {
        let userSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title:"Logout", style: .default) { action in
            let loginVC = LoginRegisterVC()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }
        
        let manageCards = UIAlertAction(title: "Manage Credit Cards", style: .default) { action in
            
        }
        
        let manageBanks = UIAlertAction(title: "Manage Bank Account", style: .default) { action in
            
        }
        
        let close = UIAlertAction(title: "Close", style: .cancel)
        
        userSheet.addAction(manageCards)
        userSheet.addAction(manageBanks)
        userSheet.addAction(logout)
        userSheet.addAction(close)
        
        present(userSheet, animated: true)


    }


}

