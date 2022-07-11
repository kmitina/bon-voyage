//
//  Int+Ext.swift
//  bon-voyage
//
//  Created by DVKSH on 11.07.22.
//

import Foundation

extension Int {
    
    func formatToCurrencyString() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        let nsnum = NSNumber(integerLiteral: self / 100)
        return formatter.string(from: nsnum) ?? "$$$"
        
    }
}
