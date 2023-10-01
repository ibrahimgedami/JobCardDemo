//
//  UITableViewCell + Extension.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

typealias TableViewProtocols = UITableViewDelegate & UITableViewDataSource

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<T: UITableViewCell>(_ T: UITableViewCell.Type) -> T {
        let identifier = String(describing: T.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Error in cell")
        }
        
        return cell
    }
}
