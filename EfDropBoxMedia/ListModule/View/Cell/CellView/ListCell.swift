//
//  ListCell.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

class ListCell: UITableViewCell, ReusableCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var mediaImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var widthImage: NSLayoutConstraint!
    
    var viewModel: ListCellViewModelProtocol?
    private let helper: ListHelper = ListHelper()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mediaImage.layer.cornerRadius = 10
        mediaImage.layer.masksToBounds = true
    }
    
    func configure(model: List) {
        if viewModel == nil {
            viewModel = ListCellViewModel()
        }
        if let path = model.pathLower {
            viewModel?.downLoad(path) { [unowned self] result in
                switch result {
                case .loaded(let path):
                    if let image = helper.getImage(name: path) {
                        DispatchQueue.main.async { [unowned self] in
                            widthImage.constant = helper.aspectRatio(image, myViewHeight: mediaImage.frame.size.height)
                            mediaImage.image = image
                            nameLabel.text = helper.removeEnding(model.name)
                        }
                    }
                case .startDownloading:
                    print("startDownloading")
                case .error:
                    print("error")
                }
            }
        }
    }
}
