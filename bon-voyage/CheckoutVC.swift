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
        
        setupTapGestiures()
        setupUi()
        setCheckoutLabelDetail()
        
    }
    
    func setCheckoutLabelDetail() {
        priceLbl.text = "Package Price: \(vacation.price.formatToCurrencyString())"
        
        let processingFee = FeesCalculator.calculateFeesForCard(subtotal: vacation.price)
        processingFeeLbl.text = "Processing Fees: \(processingFee.formatToCurrencyString())"
        
        let total = processingFee + vacation.price
        totalLbl.text = "Total: \(total.formatToCurrencyString())"
    }
    
    func setupTapGestiures() {
        let selectCardTouch = UITapGestureRecognizer(target: self, action: #selector(selectCardTapped))
        selectCardView.addGestureRecognizer(selectCardTouch)
        
        let selectBankTouch = UITapGestureRecognizer(target: self, action: #selector(selectBankTapped))
        selectBankView.addGestureRecognizer(selectBankTouch)
    }
    
    func setupUi() {
        vacationTitle.text = vacation.title
        airfareLbl.text = vacation.airfare
        detailsPriceLbl.text = "All inclusive price: " + vacation.price.formatToCurrencyString()
        numberOfNightsLbl.text = "\(vacation.numberOfNights) night accomodations"
        
        priceLbl.text = vacation.price.formatToCurrencyString()
    }
    
        // MARK: Select Card
    
    @objc func selectCardTapped() {
        setCardPaymentView()
    }
    
    func setCardPaymentView() {
        if currentSelectedPaymentType == .card { return }
        
        currentSelectedPaymentType = .card
        
        selectCardView.layer.borderColor = UIColor(named: AppColor.BorderBlue)?.cgColor
        selectCardView.layer.borderWidth = 2
        selectBankView.layer.borderColor = UIColor.lightGray.cgColor
        selectBankView.layer.borderWidth = 1
        
        cardIcon.tintColor = UIColor(named: AppColor.BorderBlue)
        bankIcon.tintColor = UIColor.lightGray
    }
    
    // MARK: Select Bank
    @objc func selectBankTapped() {
        
        setBankPaymentView()
        
    }
    
    func setBankPaymentView() {
        if currentSelectedPaymentType == .bank { return }
        
        currentSelectedPaymentType = .bank
        
        selectBankView.layer.borderColor = UIColor(named: AppColor.BorderBlue)?.cgColor
        selectBankView.layer.borderWidth = 2
        selectCardView.layer.borderColor = UIColor.lightGray.cgColor
        selectCardView.layer.borderWidth = 1
        
        bankIcon.tintColor = UIColor(named: AppColor.BorderBlue)
        cardIcon.tintColor = UIColor.lightGray
    }
    
    @IBAction func changeCardClicked(_ sender: Any) {
        
    }
    
    @IBAction func changeBankClicked(_ sender: Any) {
        
    }
    
    @IBAction func payButtonClicked(_ sender: Any) {
        
    }
    
}

enum PaymentType {
    case card
    case bank
}
