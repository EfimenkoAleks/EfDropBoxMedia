//
//  ListTableViewManager.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit

enum ListEvent {
    case selectedVideo(String?)
    case selectedPhoto(String?)
}

class ListTableViewManager: NSObject {

    private let helper: ListHelper = ListHelper()
    
    var tableView: UITableView
    var data: [List]
    var eventHandler: ((ListEvent) -> Void)?
    
    init(_ tableView: UITableView, data: [List]) {
        self.tableView = tableView
        self.data = data
        super.init()
        
        registerTableViewCells()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func reloadTable(data: [List]) {
        self.data = data
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension ListTableViewManager {
    
    func registerTableViewCells() {
        tableView.register(VideoCell.nib, forCellReuseIdentifier: ConstantId.videoCell)
        tableView.register(PhotoCell.nib, forCellReuseIdentifier: ConstantId.photoCell)
    }
}

extension ListTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = helper.defineContent(str: data[indexPath.row].name)
        
        switch type {
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantId.photoCell, for: indexPath)
                    as? PhotoCell else { return UITableViewCell() }
            
            let list = data[indexPath.row]
            
            cell.configure(model: list)
            return cell
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantId.videoCell, for: indexPath)
                    as? VideoCell else { return UITableViewCell() }
            
            let list = data[indexPath.row]
            
            cell.configure(model: list)
            return cell
        case .notSupported:
            return UITableViewCell()
        }
    }
}

extension ListTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        let type = helper.defineContent(str: model.name)
        switch type {
        case .video:
            eventHandler?(.selectedVideo(model.pathLower))
        case .photo:
            eventHandler?(.selectedPhoto(model.pathLower))
        default:
            break
        }
    }
}
