//
//  AdTableViewCell.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/11.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
static let identifier = "AdTableViewCell"
    
    @IBOutlet var adView: UIView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var AdButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
        adView.clipsToBounds = true
        adView.layer.cornerRadius = 10
        
        adLabel.textAlignment = .center
        adLabel.numberOfLines = 0
    }
    
}

