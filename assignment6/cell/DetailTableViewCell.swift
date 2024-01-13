//
//  DetailTableViewCell.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/11.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"
    @IBOutlet var spotNameLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var thumnailImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var saveLabel: UILabel!
    
    @IBOutlet var startsImageView: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subLabel.numberOfLines = 0
        subLabel.textColor = .gray
        subLabel.font = .systemFont(ofSize: 12)
        thumnailImageView.contentMode = .scaleAspectFill
        thumnailImageView.clipsToBounds = true
        thumnailImageView.layer.cornerRadius = 20
        startsImageView.forEach { el in
            el.tintColor = .green
        }
    }


}
