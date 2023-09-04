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
        
        bindUI()
        view.backgroundColor = .systemPink
        tableView.backgroundColor = .systemMint
    }
    
    func bindUI() {
        title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true
    
        viewModel.fetchList = { [unowned self] newList in
            DispatchQueue.main.async {
                self.setupTable(newList)
            }
        }
    }
    
    func setupTable(_ data: [String]) {
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
