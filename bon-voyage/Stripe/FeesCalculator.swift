//
//  FeesCalculator.swift
//  bon-voyage
//
//  Created by DVKSH on 3.08.22.
//

import Foundation

class FeesCalculator {
    
    private static let stripeCreditCardCut = 0.029
    private static let flatFeeCents = 30
    
    static func calculateFeesForCard(subtotal: Int) -> Int {
        if subtotal == 0 {
            return 0
        }
        
            // vacation = 999 *0.029 + 0.3
        let fees = Int(Double(subtotal) * stripeCreditCardCut) +  flatFeeCents
        return fees
    }
}
