//
//  CheckoutVC.swift
//  bon-voyage
//
//  Created by DVKSH on 14.07.22.
//

import UIKit
import FirebaseFunctions
import FirebaseFirestore
import FirebaseAuth
import Stripe

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
    
    var paymentContext: STPPaymentContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStripe()
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
    
    func setupStripe() {
        
        guard (UserManager.instance.user?.stripeId) != nil else { return }
        
        let config = STPPaymentConfiguration.shared
        paymentContext = STPPaymentContext(customerContext: Wallet.instance.customerContext, configuration: config, theme: .defaultTheme)
        paymentContext.hostViewController = self
        paymentContext.delegate = self
    }
    
    
    @IBAction func changeCardClicked(_ sender: Any) {
        self.paymentContext.pushPaymentOptionsViewController()
    }
    
    @IBAction func changeBankClicked(_ sender: Any) {
        
    }
    
    @IBAction func payButtonClicked(_ sender: Any) {
        
    }
    
}

// MARK: Stripe Delegate Psudeo Code

extension CheckoutVC: STPPaymentContextDelegate {
    
    // MARK: Payment Context Changed
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        // Triggers when the content of the payment context changes, like when the user selects a new payment method or enters shipping information.
        
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    // MARK: Create Payment Intent
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        // Request Stripe payment intent, and return client secret.
              // The client secret can be used to complete a payment from your frontend.
              // Once the client secret is obtained, create paymentIntentParams
              // Confirm the PaymentIntent
              // STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: paymentContext)
        
        
        
    }
    // MARK: DId Finish Payment
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
        // Take action based on return status: error, success, userCancellation

    }
    
    
}

enum PaymentType {
    case card
    case bank
}
