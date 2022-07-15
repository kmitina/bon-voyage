//
//  CheckoutVC.swift
//  bon-voyage
//
//  Created by DVKSH on 14.07.22.
//

import UIKit

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var vacationTitle: UILabel!
    @IBOutlet weak var airfareLbl: UILabel!
    @IBOutlet weak var numberOfNightsLbl: UILabel!
    @IBOutlet weak var detailsPriceLbl: UILabel!

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    @IBOutlet weak var selectCardView: UIView!
    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var cardEndingIn: UILabel!
    @IBOutlet weak var selectBankView: UIView!
    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var bankEndingIn: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var vacation: Vacation!
    
    var currentSelectedPaymentType: PaymentType?

    override func viewDidLoad() {
        super.viewDidLoad()

        let selectCardTouch = UITapGestureRecognizer(target: self, action: #selector(selectCardTapped))
        selectCardView.addGestureRecognizer(selectCardTouch)
        
        let selectBankTouch = UITapGestureRecognizer(target: self, action: #selector(selectBankTapped))
        selectBankView.addGestureRecognizer(selectBankTouch)
        
        vacationTitle.text = vacation.title
        airfareLbl.text = vacation.airfare
        detailsPriceLbl.text = "All inclusive price: " + vacation.price.formatToCurrencyString()
        numberOfNightsLbl.text = "\(vacation.numberOfNights) night accomodations"
        
        priceLbl.text = vacation.price.formatToCurrencyString()

    }
    
    @objc func selectCardTapped() {
        if currentSelectedPaymentType == .card { return }
        
        currentSelectedPaymentType = .card
        
        selectCardView.layer.borderColor = UIColor(named: "border_blue")?.cgColor
        selectCardView.layer.borderWidth = 2
        selectBankView.layer.borderColor = UIColor.lightGray.cgColor
        selectBankView.layer.borderWidth = 1
        
        cardIcon.tintColor = UIColor(named: "border_blue")
        bankIcon.tintColor = UIColor.lightGray
    }
    
    @objc func selectBankTapped() {
        
        if currentSelectedPaymentType == .bank { return }
        
        currentSelectedPaymentType = .bank
        
        selectBankView.layer.borderColor = UIColor(named: "border_blue")?.cgColor
        selectBankView.layer.borderWidth = 2
        selectCardView.layer.borderColor = UIColor.lightGray.cgColor
        selectCardView.layer.borderWidth = 1
        
        bankIcon.tintColor = UIColor(named: "border_blue")
        cardIcon.tintColor = UIColor.lightGray
        
    }

}

enum PaymentType {
    case card
    case bank
}
