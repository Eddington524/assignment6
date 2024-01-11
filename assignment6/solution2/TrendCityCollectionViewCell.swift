//
//  TrendCityCollectionViewCell.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/09.
//

import UIKit

class TrendCityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieTableViewCell"

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: 24 )
        titleLabel.textAlignment = .center
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 0
        
    }
    
    // view drawing cycle
    override func layoutSubviews() {
        imageView.layer.cornerRadius = imageView.layer.frame.height / 2
        imageView.contentMode = .scaleAspectFill
    }

}
