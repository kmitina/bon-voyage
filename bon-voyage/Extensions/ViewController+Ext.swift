//
//  ViewController+Ext.swift
//  bon-voyage
//
//  Created by DVKSH on 19.07.22.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(title: String? = "Error", msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
