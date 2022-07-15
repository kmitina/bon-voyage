//
//  ThumbnailCell.swift
//  bon-voyage
//
//  Created by DVKSH on 12.07.22.
//

import UIKit
import SDWebImage

class ThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    func configureCell(url: String) {
        
        img.layer.cornerRadius = 5
        guard let url = URL(string: url) else { return }
        img.sd_imageIndicator = SDWebImageActivityIndicator.medium
        img.sd_setImage(with: url, placeholderImage: UIImage(named: ImageName.PlaceholderImage))
    }
}
