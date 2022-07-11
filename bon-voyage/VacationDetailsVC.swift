//
//  VacationDetailsVC.swift
//  bon-voyage
//
//  Created by DVKSH on 11.07.22.
//

import UIKit

class VacationDetailsVC: UIViewController {
    
    @IBOutlet weak var activitiesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    
    var vacation: Vacation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = vacation.title
        
        activitiesLbl.text = vacation.activities
        descriptionLbl.text = vacation.description

    }


}
