//
//  ListViewController.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    lazy var viewModel: ListViewModelProtocol = {
        let viewModel = ListViewModel()
        return viewModel
    }()
    private var tableViewManager: ListTableViewManager?
    
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
                self.setupTable(newList)
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
            case .selected(let model):
                break
            default:
                break
            }
        }
    }
}
