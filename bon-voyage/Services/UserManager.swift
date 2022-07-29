//
//  UserManager.swift
//  bon-voyage
//
//  Created by DVKSH on 29.07.22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManager {
    
    static let instance = UserManager()
    private init() {}
    
    var user: User?
    let auth = Auth.auth()
    
    func getCurrentUser( completion: @escaping () -> ()) {
        
        guard let user = auth.currentUser else { return }
        
        let userRef =  Firestore.firestore().collection("users").document(user.uid)
        
        userRef.getDocument { snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = snapshot?.data() else { return }
        
            self.user = User.initFrom(data)
            completion()
        }
    }
    
}
