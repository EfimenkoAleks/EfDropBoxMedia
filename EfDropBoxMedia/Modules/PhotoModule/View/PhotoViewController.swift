//
//  PhotoViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 12.09.2023.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: — properties
    
    var coordinator: PhotoCoordinatorProtocol?
    
    private var path: String?
    
    lazy var viewModel: PhotoViewModelProtocol = {
        let viewModel = PhotoViewModel()
        return viewModel
    }()
    
    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var modifierLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    
    // MARK: — lifecycle
    
    init(with path: String?) {
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }
    
    deinit {
        coordinator?.handlerBack?()
    }
}

// MARK: — private fanc

private extension PhotoViewController {
    
    func bindUI() {
        viewModel.fetchPhoto = { result in
            DispatchQueue.main.async { [weak self] in
                if let photo = result {
                    self?.configureUI(model: photo)
                }
            }
        }
        if let path = self.path {
            viewModel.fechData(path: path)
        }
    }
    
    func configureUI(model: PhotoModel) {
        
        nameLabel.text = viewModel.trimSlash(name: model.name)
        modifierLabel.text = Date.convertDateToString(date: model.modified)
        sizeLabel.text = viewModel.convertToMB(size: model.size)
        contentImageView.image = viewModel.getImage(path: model.pathLower)
    }
}
