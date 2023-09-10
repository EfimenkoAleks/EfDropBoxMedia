//
//  ListTableViewManager.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

enum ListEvent {
    case selected(String)
}

class ListTableViewManager: NSObject {
    
    private var isLoadingList: Bool = false
    
    var tableView: UITableView
    var data: [String]
    var eventHandler: ((ListEvent) -> Void)?
    
    init(_ tableView: UITableView, data: [String]) {
        self.tableView = tableView
        self.data = data
        super.init()
        
        registerTableViewCells()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func reloadTable(data: [String]) {
        self.data = data
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension ListTableViewManager {
    
    func registerTableViewCells() {
        tableView.register(ListCell.nib, forCellReuseIdentifier: ConstantId.listCell)
    }
}

extension ListTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantId.listCell, for: indexPath)
                as? ListCell else { return UITableViewCell() }
        
        let model = data[indexPath.row]
        
        cell.configure(path: model)
        return cell
    }
}

extension ListTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?(.selected(data[indexPath.row]))
    }
}
