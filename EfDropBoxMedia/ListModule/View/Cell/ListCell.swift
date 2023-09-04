//
//  ListCell.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

class ListCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: String) {
        
    }
}
