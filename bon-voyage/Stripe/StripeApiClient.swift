//
//  StripeApiClient.swift
//  bon-voyage
//
//  Created by DVKSH on 1.08.22.
//

import Foundation
import Stripe
import FirebaseFunctions

class StripeApiClient: NSObject, STPCustomerEphemeralKeyProvider {
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let data = [
            "stripe_version": apiVersion,
            "customer_id": UserManager.instance.user?.stripeId
        ]
        
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { result, error in
            if let error = error {
                debugPrint(error)
                return completion(nil, error)
            }
            
            guard let json = result?.data as? [String: Any] else {
                return completion(nil, nil)
            }
            
            completion(json, nil)
        }
    }
    
    
}
