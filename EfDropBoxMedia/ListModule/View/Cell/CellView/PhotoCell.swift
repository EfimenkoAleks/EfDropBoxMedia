//
//  PhotoCell.swift
//  EfDropBoxMedia
//
//  Created by user on 11.09.2023.
//

import UIKit

class PhotoCell: UITableViewCell, ReusableCell {
    
    @IBOutlet private weak var containerForContentView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var photoImage: UIImageView!
    @IBOutlet private weak var widthImage: NSLayoutConstraint!
    
    var viewModel: ListCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    func configure(model: List) {
        if viewModel == nil {
            viewModel = ListCellViewModel()
        }
        if let path = model.pathLower {
            viewModel?.downLoad(path) { [unowned self] result in
                switch result {
                case .loaded(let path):
                    setPhoto(path: path, name: model.name)
                default:
                    break
                }
            }
        }
    }
    
    private func setPhoto(path: String, name: String?) {
        if let viewModel = viewModel, let image = viewModel.getImageFromPath(path) {
            DispatchQueue.main.async { [unowned self] in
                widthImage.constant = viewModel.newWidth(image: image, height: containerForContentView.frame.size.height)
                photoImage.image = image
                nameLabel.text = viewModel.removeEndingFrom(name)
            }
        }
    }
    
    private func configUI() {
        containerForContentView.layer.cornerRadius = 10
        containerForContentView.layer.masksToBounds = true
    }
}
