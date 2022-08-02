//
//  Wallet.swift
//  bon-voyage
//
//  Created by DVKSH on 2.08.22.
//

import Foundation
import Stripe

class Wallet {
    static let instance = Wallet()
    
    private init() {}
    
    var customerContext: STPCustomerContext!
}
