//
//  ListViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: — properties
    
    var coordinator: ListCoordinatorProtocol?

    @IBOutlet private weak var tableView: UITableView!
    
    lazy var viewModel: ListViewModelProtocol = {
        let viewModel = ListViewModel()
        return viewModel
    }()
    private var tableViewManager: ListTableViewManager?
    
    // MARK: — lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        bindUI()
    }
}

private extension ListViewController {
    
    func bindUI() {
        viewModel.fetchList = { [unowned self] newList in
            DispatchQueue.main.async {
                if self.tableViewManager == nil {
                    self.setupTable(newList)
                } else {
                    self.reloadTableWithNewData(newList)
                }
            }
        }
    }
    
    func configUI() {
        title = "List of files"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemMint
    }
    
    func setupTable(_ data: [List]) {
        self.tableViewManager = ListTableViewManager(tableView, data: data)
        self.tableViewManager?.eventHandler = { [unowned self] event in
            switch event {
            case .selectedPhoto(let model):
                coordinator?.eventOccurred(with: .photo(model))
            case .selectedVideo(let model):
                coordinator?.eventOccurred(with: .video(model))
            case .loadMore:
                viewModel.fechData()
            }
        }
    }
    
    func reloadTableWithNewData(_ data: [List]) {
        tableViewManager?.reloadTable(data: data)
    }
}
