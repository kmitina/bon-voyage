//
//  VacationCell.swift
//  bon-voyage
//
//  Created by DVKSH on 5.07.22.
//

import UIKit
import SDWebImage

class VacationCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func configureCell(vacation: Vacation) {
        titleLbl.text = vacation.title
        priceLbl.text = vacation.price.formatToCurrencyString()
        
        let imageUrl = vacation.images[0]
        if let url = URL(string: imageUrl) {
            mainImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            mainImage.sd_setImage(with: url, placeholderImage: UIImage(named: ImageName.PlaceholderImage))
        }
        
    }
    
}
