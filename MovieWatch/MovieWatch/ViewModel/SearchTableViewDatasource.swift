//
//  SearchTableViewDatasource.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation
import UIKit

protocol TableViewDatasource: UITableViewDelegate, UITableViewDataSource {
}

class SearchTableViewDatasource<T, Cell: UITableViewCell>: NSObject, TableViewDatasource {
    var items: [T]
    var configure: (Cell, T, IndexPath) -> Void
    var cellSelectionHandler: (T, IndexPath) -> Void
    var cellId: String
    
    override init() {
        items = []
        configure = { cell, item, indexPath in
        }
        cellSelectionHandler = { item, indexPath in
        }
        cellId = ""
    }
    
    init(items: [T], cellId: String, configure: @escaping (Cell, T, IndexPath) -> Void, selectionHandler: @escaping (T, IndexPath) -> Void) {
        self.items = items
        self.cellId = cellId
        self.configure = configure
        self.cellSelectionHandler = selectionHandler
    }
    
    func updateItems(items: [T]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? Cell else { return UITableViewCell () }
        configure(_cell, items[indexPath.row], indexPath)
        return _cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellSelectionHandler(items[indexPath.row], indexPath)
    }
}
