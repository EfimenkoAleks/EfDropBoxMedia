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

    var viewModel: ListCellViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(path: String) {
        if viewModel == nil {
            viewModel = ListCellViewModel()
        }
        viewModel?.downLoad(path) { [unowned self] result in
            switch result {
            case .loaded(let path):
                if let image = getImage(name: path) {
                    DispatchQueue.main.async { [unowned self] in
                        mediaImage.image = image
                    }
                }
            case .startDownloading:
                print("startDownloading")
            case .error:
                print("error")
            }
        }
    }
    
    private func getImage(name: String) -> UIImage? {
        // swiftlint:disable force_unwrapping
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        let image = UIImage(contentsOfFile: fileURL.path)

        return image
    }
}
