//
//  VacationDetailsVC.swift
//  bon-voyage
//
//  Created by DVKSH on 11.07.22.
//

import UIKit

class VacationDetailsVC: UIViewController {
    
    var vacation: Vacation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = vacation.title

    }


}
